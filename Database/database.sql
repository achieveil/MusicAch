CREATE DATABASE IF NOT EXISTS MusicAch DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE MusicAch;

-- 用户表
CREATE TABLE Users (
                       UserID INT PRIMARY KEY AUTO_INCREMENT,
                       Username VARCHAR(50) UNIQUE NOT NULL,
                       Password VARCHAR(255) NOT NULL,
                       Email VARCHAR(100),
                       CreateTime DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 音乐表
CREATE TABLE Music (
                       MusicID INT PRIMARY KEY AUTO_INCREMENT,
                       Title VARCHAR(200) NOT NULL,
                       MusicUrl VARCHAR(500) NOT NULL,
                       CoverUrl VARCHAR(500),
                       UserID INT,
                       CreateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- 添加索引提高查询性能
CREATE INDEX idx_music_userid ON Music(UserID);