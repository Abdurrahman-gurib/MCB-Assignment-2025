using BCrypt.Net;
using MCBBackend.Models;
using System.Collections.Concurrent;

namespace MCBBackend.Services
{
    public interface IUserService
    {
        User Register(User user);
        User Authenticate(string username, string password);

        // Save the refresh token for the user
        void SaveRefreshToken(string username, string refreshToken);

        // Validate and return a new access token if the refresh token is valid
        // For demonstration, we'll return the username if valid. In production, you'll issue a new JWT.
        string ValidateRefreshToken(string refreshToken);
    }

    public class UserService : IUserService
    {
        // In-memory storage for users
        private static ConcurrentDictionary<string, User> _users = new();

        // In-memory storage for refresh tokens, mapping username to refresh token
        private static ConcurrentDictionary<string, string> _refreshTokens = new();

        public User Register(User user)
        {
            if (_users.ContainsKey(user.Username))
                return null;

            // Hash and salt the password before storing
            user.Password = BCrypt.Net.BCrypt.HashPassword(user.Password);
            _users[user.Username] = user;
            return user;
        }

        public User Authenticate(string username, string password)
        {
            if (_users.TryGetValue(username, out var user))
            {
                // Verify hashed password
                if (BCrypt.Net.BCrypt.Verify(password, user.Password))
                    return user;
            }
            return null;
        }

        public void SaveRefreshToken(string username, string refreshToken)
        {
            // Save or update the refresh token for the given username
            _refreshTokens[username] = refreshToken;
        }

        public string ValidateRefreshToken(string refreshToken)
        {
            // Check if the provided refresh token exists in our store and return the associated username
            foreach (var kvp in _refreshTokens)
            {
                if (kvp.Value == refreshToken)
                {
                    // In a real-world scenario, you would verify token expiration and possibly issue a new JWT here.
                    return kvp.Key;
                }
            }
            return null;
        }
    }
}
