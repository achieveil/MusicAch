using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace MusicAch.Models
{
    public class DBHelper
    {
        private static readonly string connectionString =
            ConfigurationManager.ConnectionStrings["MusicAchDB"].ConnectionString;

        /// <summary>
        ///     执行查询返回DataTable
        /// </summary>
        public static DataTable ExecuteQuery(string sql, params MySqlParameter[] parameters)
        {
            try
            {
                using (var conn = new MySqlConnection(connectionString))
                {
                    using (var cmd = new MySqlCommand(sql, conn))
                    {
                        if (parameters != null) cmd.Parameters.AddRange(parameters);

                        var adapter = new MySqlDataAdapter(cmd);
                        var dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("数据库查询错误: " + ex.Message);
            }
        }

        /// <summary>
        ///     执行非查询操作（增删改）
        /// </summary>
        public static int ExecuteNonQuery(string sql, params MySqlParameter[] parameters)
        {
            try
            {
                using (var conn = new MySqlConnection(connectionString))
                {
                    using (var cmd = new MySqlCommand(sql, conn))
                    {
                        if (parameters != null) cmd.Parameters.AddRange(parameters);

                        conn.Open();
                        return cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("数据库操作错误: " + ex.Message);
            }
        }

        /// <summary>
        ///     执行查询返回单个值
        /// </summary>
        public static object ExecuteScalar(string sql, params MySqlParameter[] parameters)
        {
            try
            {
                using (var conn = new MySqlConnection(connectionString))
                {
                    using (var cmd = new MySqlCommand(sql, conn))
                    {
                        if (parameters != null) cmd.Parameters.AddRange(parameters);

                        conn.Open();
                        return cmd.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("数据库查询错误: " + ex.Message);
            }
        }

        /// <summary>
        ///     测试数据库连接
        /// </summary>
        public static bool TestConnection()
        {
            try
            {
                using (var conn = new MySqlConnection(connectionString))
                {
                    conn.Open();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
    }
}