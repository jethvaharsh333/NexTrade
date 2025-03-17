using Microsoft.AspNetCore.Identity;
using NexTrade.Dtos.Account;
using NexTrade.Models;

namespace NexTrade.Mappers
{
    public static class AccountMappers
    {
        public static CurrentUserDto ToCurrentUserDto(this UserModel user)
        {
            return new CurrentUserDto
            {
                UserName = user.UserName,
                Email = user.Email,
                Name = user.Name,
                PhoneNumber = user.PhoneNumber
            };
        }
    }
}
