using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using NexTrade.Controllers;
using NexTrade.Data;
using NexTrade.Interfaces;
using NexTrade.Interfaces.Portfolio;
using NexTrade.Interfaces.Stock;
using NexTrade.Models;
using NexTrade.Repository;
using NexTrade.Service;

var builder = WebApplication.CreateBuilder(args);

//builder.Services.AddCors(options =>
//{
//    options.AddPolicy("AllowAll",
//        builder =>
//        {
//            builder
//                .AllowAnyOrigin()     // WARNING: Use specific origins in production
//                //.WithOrigins(
//                //    "http://localhost:3000",     // Flutter web default
//                //    "http://localhost:5173",     // Alternative port
//                //    "http://127.0.0.1:3000" ,    // Using IP
//                //    "http://10.0.2.2:5000"
//                //)
//                .AllowAnyMethod()
//                .AllowAnyHeader();
//        });
//});



builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "NexTrade APIs", Version = "v1" });
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});

builder.Services.AddControllers().AddNewtonsoftJson(options =>
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
);

builder.Services.AddDbContext<ApplicationDBContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
});

builder.Services.AddIdentity<UserModel, IdentityRole>(options =>
{
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireNonAlphanumeric = true;
    options.Password.RequiredLength = 12;
}).AddEntityFrameworkStores<ApplicationDBContext>();

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme =
    options.DefaultChallengeScheme =
    options.DefaultForbidScheme =
    options.DefaultScheme =
    options.DefaultSignInScheme =
    options.DefaultSignOutScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = builder.Configuration["JWT:Issuer"],
        ValidateAudience = true,
        ValidAudience = builder.Configuration["JWT:Audience"],
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(
            System.Text.Encoding.UTF8.GetBytes(builder.Configuration["JWT:SigningKey"])
        )
    };
});

builder.Services.AddScoped<IStockRepository, StockRepository>();
builder.Services.AddScoped<IStockService, StockRepository>();
builder.Services.AddScoped<ICommentRepository, CommentRepository>();
builder.Services.AddScoped<IPortfolioRepository, PortfolioRepository>();
builder.Services.AddScoped<IPortfolioService, PortfolioRepository>();
builder.Services.AddScoped<IWatchlistRepository, WatchlistRepository>();
builder.Services.AddScoped<NewsService>();
builder.Services.AddScoped<ITokenService, TokenService>();

//builder.Services.AddCors(options =>
//{
//    options.AddPolicy("AllowAllOrigins", policy =>
//    {
//        policy.AllowAnyOrigin()
//              .AllowAnyMethod()
//              .AllowAnyHeader();
//    });
//});
//var MyPolicy = "_myPolicy";

//builder.Services.AddCors(options =>
//{
//    options.AddPolicy(name: "MyPolicy",
//        policy =>
//        {
//            policy.WithOrigins("http://localhost:50666/", "http://example.com",
//                    "http://www.contoso.com",
//                    "https://cors1.azurewebsites.net",
//                    "https://cors3.azurewebsites.net",
//                    "https://localhost:44398",
//                    "https://localhost:5001");
//        });
//});

builder.Services.AddHttpClient<FlaskService>();  // Register FlaskService
builder.Services.AddHttpClient<NewsService>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(x => x.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());



//if (app.Environment.IsDevelopment())
//{
//    app.UseCors("AllowAllOrigins");
//}
//app.UseCors(MyPolicy);
//app.UseCors("AllowAll");

app.UseHttpsRedirection();
//app.UseCors("AllowAllOrigins");
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

// https://localhost:7203/api/