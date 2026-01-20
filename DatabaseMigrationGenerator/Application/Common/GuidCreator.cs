// -----------------------------------------------------------------------------
// <copyright company="Hypothekarbank Lenzburg">
//     Copyright (c) Hypothekarbank Lenzburg. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------------

using System.Security.Cryptography;
using System.Text;

namespace Finstar.DatabaseMigrationGenerator.Application.Common
{
    public static class GuidCreator
    {
        public static Guid CreateDeterministicGuid(string input)
        {
            using MD5 md5 = MD5.Create();
            byte[] hashBytes = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
            
            hashBytes[6] = (byte)((hashBytes[6] & 0x0F) | 0x30); // Version 3
            hashBytes[8] = (byte)((hashBytes[8] & 0x3F) | 0x80); // Variant: RFC 4122

            return new Guid(hashBytes);
        }
    }
}