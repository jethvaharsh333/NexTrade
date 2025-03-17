using NexTrade.Models;

namespace NexTrade.Interfaces
{
    public interface ITokenService
    {
        string CreateToken(UserModel user);
    }
}
