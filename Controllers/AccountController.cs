using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NexTrade.Dtos.Account;
using NexTrade.Interfaces;
using NexTrade.Models;
using NexTrade.Extensions;
using Microsoft.AspNetCore.Authorization;
using NexTrade.Repository;
using NexTrade.Mappers;


namespace NexTrade.Controllers
{
    [Route("api/account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<UserModel> _userManager;
        private readonly ITokenService _tokenService;
        private readonly SignInManager<UserModel> _signinManager;

        public AccountController(UserManager<UserModel> userManager, ITokenService tokenService, SignInManager<UserModel> signInManager)
        {
            _userManager = userManager;
            _tokenService = tokenService;
            _signinManager = signInManager;
        }

        [HttpGet("get-current-user")]
        [Authorize]
        public async Task<IActionResult> GetCurrentUser()
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);
                return Ok(appUser.ToCurrentUserDto());
            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            var user = (UserModel)null;

            if (loginDto.Identifier.IsEmail())
            {
                user = await _userManager.Users.FirstOrDefaultAsync(e => e.Email == loginDto.Identifier);
            }
            else
            {
                user = await _userManager.Users.FirstOrDefaultAsync(x => x.UserName == loginDto.Identifier.ToLower());
            }

            if (user == null) return Unauthorized("Invalid identifier!");

            var result = await _signinManager.CheckPasswordSignInAsync(user, loginDto.Password, false);

            if (!result.Succeeded) return Unauthorized("Incorrect password.");

            return Ok(
                new NewUserDto
                {
                    UserName = user.UserName,
                    Email = user.Email,
                    Token = _tokenService.CreateToken(user)
                }
            );
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var username = await _userManager.Users.FirstOrDefaultAsync(x => x.UserName == registerDto.UserName.ToLower());
                if(username != null) return BadRequest("Username already exists!");

                var email = await _userManager.Users.FirstOrDefaultAsync(x => x.Email == registerDto.Email.ToLower());
                if (email != null) return BadRequest("Email already exists!");

                var appUser = new UserModel
                {
                    UserName = registerDto.UserName,
                    Email = registerDto.Email
                };

                var createdUser = await _userManager.CreateAsync(appUser, registerDto.Password);

                if (createdUser.Succeeded)
                {
                    var roleResult = await _userManager.AddToRoleAsync(appUser, "User");
                    if (roleResult.Succeeded)
                    {
                        return Ok(
                            "Registerd successfully!"
                        );
                    }
                    else
                    {
                        return StatusCode(500, roleResult.Errors);
                    }
                }
                else
                {   
                    return StatusCode(500, createdUser.Errors);
                }
            }
            catch (Exception e)
            {
                return StatusCode(500, e);
            }
        }

        [HttpPost("logout")]
        [Authorize]
        public async Task<IActionResult> Logout([FromBody] CurrentUserDto currentUserDto)
        {
            try
            {
                await _signinManager.SignOutAsync();
                return Ok(new { message = "Logged out successfully" });
            }
            catch (Exception e)
            {
                return StatusCode(500, new { error = e.Message });
            }
        }

        [HttpPut("update-profile")]
        [Authorize]
        public async Task<IActionResult> UpdateProfile([FromBody] UpdateUserDto updateUserDto)
        {
            try
            {
                var username = User.GetUserName();
                var appUser = await _userManager.FindByNameAsync(username);

                if (appUser == null)
                {
                    return NotFound(new { message = "User not found" });
                }

                // Check if the new email is already in use by another user
                if (appUser.Email != updateUserDto.Email)
                {
                    var emailExists = await _userManager.Users.AnyAsync(u => u.Email == updateUserDto.Email);
                    if (emailExists)
                    {
                        return BadRequest(new { message = "Email is already taken" });
                    }
                }

                // Check if the new username is already in use by another user
                if (appUser.UserName.ToLower() != updateUserDto.UserName.ToLower())
                {
                    var usernameExists = await _userManager.Users.AnyAsync(u => u.UserName == updateUserDto.UserName);
                    if (usernameExists)
                    {
                        return BadRequest(new { message = "Username is already taken" });
                    }
                }

                appUser.Name = updateUserDto.Name;
                appUser.Email = updateUserDto.Email;
                appUser.UserName = updateUserDto.UserName;
                appUser.PhoneNumber = updateUserDto.PhoneNumber;

                var result = await _userManager.UpdateAsync(appUser);
                if (!result.Succeeded)
                {
                    return BadRequest(new { message = "Failed to update profile", errors = result.Errors });
                }

                return Ok(new { message = "Profile updated successfully!" });
            }
            catch (Exception e)
            {
                return StatusCode(500, new { error = e.Message });
            }
        }

        [HttpPut("update-password")]
        [Authorize]
        public async Task<IActionResult> UpdatePassword([FromBody] UpdateUserPassword updateUserPassword)
        {
            var username = User.GetUserName();
            var appUser = await _userManager.FindByNameAsync(username);
            if (appUser == null)
            {
                return NotFound(new { message = "User not found" });
            }

            var passwordCheck = await _userManager.CheckPasswordAsync(appUser, updateUserPassword.CurrentPassword);
            if (!passwordCheck)
            {
                return BadRequest(new { message = "Incorrect old password" });
            }

            var result = await _userManager.ChangePasswordAsync(appUser, updateUserPassword.CurrentPassword, updateUserPassword.NewPassword);
            if (!result.Succeeded)
            {
                return BadRequest(new { message = "Failed to update password", errors = result.Errors });
            }

            return Ok(new { message = "Password updated successfully!" });
        }
    }
}

/*
 {
  "message": "An error occurred",
  "error": "Object reference not set to an instance of an object."
}
 */
/*
 {email: kazekage@gmail.com, userName: kazekage, password: Kazekage.j9999}
 */
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJoYXJzaEBnbWFpbC5jb20iLCJlbWFpbCI6ImhhcnNoQGdtYWlsLmNvbSIsImdpdmVuX25hbWUiOiJoYXJzaCIsIm5iZiI6MTc0MTIzNTU3NiwiZXhwIjoxNzQxMzIxOTc2LCJpYXQiOjE3NDEyMzU1NzYsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI0NiIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI0NiJ9.OKtfCEd65yllILVD9I5UFsU8MjcASKjjpVyQv14N6BE