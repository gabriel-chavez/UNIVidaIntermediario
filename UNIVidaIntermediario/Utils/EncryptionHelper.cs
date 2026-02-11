using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;

namespace UNIVidaVentaRural.Utils
{
    public static class EncryptionHelper
    {
        // Clave desde web.config o por defecto
        private static string GetEncryptionKey()
        {
            string key = WebConfigurationManager.AppSettings["EncryptionKey"];

            if (string.IsNullOrEmpty(key))
            {                
                key = "b14ca5898a4e4133bbce2ea2315a1916";
                System.Diagnostics.Trace.TraceWarning("Usando clave de encriptación por defecto");
            }

            // Asegurar que tenga 32 caracteres (256 bits)
            if (key.Length < 32)
                key = key.PadRight(32, '0');
            else if (key.Length > 32)
                key = key.Substring(0, 32);

            return key;
        }

        /// <summary>
        /// Encripta texto simple
        /// </summary>
        public static string Encrypt(string plainText)
        {
            if (string.IsNullOrEmpty(plainText))
                return string.Empty;

            try
            {
                string key = GetEncryptionKey();
                byte[] iv = new byte[16];

                using (var aes = Aes.Create())
                {
                    aes.Key = Encoding.UTF8.GetBytes(key);
                    aes.IV = iv;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;

                    using (var encryptor = aes.CreateEncryptor())
                    {
                        byte[] plainBytes = Encoding.UTF8.GetBytes(plainText);
                        byte[] encryptedBytes = encryptor.TransformFinalBlock(plainBytes, 0, plainBytes.Length);
                        return Convert.ToBase64String(encryptedBytes);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError($"Error en Encrypt: {ex.Message}");
                throw;
            }
        }

        /// <summary>
        /// Desencripta texto
        /// </summary>
        public static string Decrypt(string encryptedText)
        {
            if (string.IsNullOrEmpty(encryptedText))
                return "";

            try
            {
                string key = GetEncryptionKey();
                byte[] iv = new byte[16];

                using (var aes = Aes.Create())
                {
                    aes.Key = Encoding.UTF8.GetBytes(key);
                    aes.IV = iv;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;

                    using (var decryptor = aes.CreateDecryptor())
                    {
                        byte[] encryptedBytes = Convert.FromBase64String(encryptedText);
                        byte[] plainBytes = decryptor.TransformFinalBlock(encryptedBytes, 0, encryptedBytes.Length);
                        return Encoding.UTF8.GetString(plainBytes);
                    }
                }
            }
            catch (FormatException)
            {
                return "ERROR: Texto encriptado inválido";
            }
            catch (CryptographicException)
            {
                return "ERROR: Clave de encriptación incorrecta";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError($"Error en Decrypt: {ex.Message}");
                return "ERROR: Error al desencriptar";
            }
        }

        /// <summary>
        /// Crea hash de contraseña (para almacenar en BD)
        /// </summary>
        public static string HashPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
                return string.Empty;

            using (var sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));

                // Convertir a string hexadecimal
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        /// <summary>
        /// Verifica contraseña contra hash
        /// </summary>
        public static bool VerifyPassword(string password, string hashedPassword)
        {
            string hashedInput = HashPassword(password);
            return hashedInput.Equals(hashedPassword, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>
        /// Encripta para URL (Base64 seguro para URLs)
        /// </summary>
        public static string EncryptForUrl(string plainText)
        {
            string encrypted = Encrypt(plainText);
            return encrypted.Replace('+', '-').Replace('/', '_').Replace('=', '~');
        }

        /// <summary>
        /// Desencripta desde URL
        /// </summary>
        public static string DecryptFromUrl(string urlEncryptedText)
        {
            string encrypted = urlEncryptedText.Replace('-', '+').Replace('_', '/').Replace('~', '=');
            return Decrypt(encrypted);
        }
    }
}