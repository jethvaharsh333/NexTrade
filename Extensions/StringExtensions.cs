using System.Text.RegularExpressions;

namespace NexTrade.Extensions
{
    public static class StringExtensions
    {
        public static bool IsEmail(this String input)   
        {
            return Regex.IsMatch(input, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        }
    }
}
