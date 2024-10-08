USE [master]
GO
/****** Object:  Database [Examination_System]    Script Date: 28/08/2024 04:16:30 م ******/
CREATE DATABASE [Examination_System]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Examination System', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Examination System.mdf' , SIZE = 51200KB , MAXSIZE = 256000KB , FILEGROWTH = 10240KB ), 
 FILEGROUP [examFG1] 
( NAME = N'examfile1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\examfile1.ndf' , SIZE = 51200KB , MAXSIZE = 256000KB , FILEGROWTH = 10240KB )
 LOG ON 
( NAME = N'Examination System_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Examination System_log.ldf' , SIZE = 20480KB , MAXSIZE = 102400KB , FILEGROWTH = 10240KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Examination_System] ADD FILEGROUP [FG1]
GO
ALTER DATABASE [Examination_System] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Examination_System].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Examination_System] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Examination_System] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Examination_System] SET ARITHABORT OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Examination_System] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Examination_System] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Examination_System] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Examination_System] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Examination_System] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Examination_System] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Examination_System] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Examination_System] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Examination_System] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Examination_System] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Examination_System] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Examination_System] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Examination_System] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Examination_System] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Examination_System] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Examination_System] SET RECOVERY FULL 
GO
ALTER DATABASE [Examination_System] SET  MULTI_USER 
GO
ALTER DATABASE [Examination_System] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Examination_System] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Examination_System] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Examination_System] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Examination_System] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Examination_System] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Examination_System', N'ON'
GO
ALTER DATABASE [Examination_System] SET QUERY_STORE = ON
GO
ALTER DATABASE [Examination_System] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Examination_System]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculatePercentage]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculatePercentage] (@Exam_ID INT, @Student_ID INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @TotalMarks INT;
    DECLARE @MaxDegree INT;
    DECLARE @Percentage DECIMAL(5, 2);

    SELECT @TotalMarks = SUM(Mark)
    FROM Ex_Result
    WHERE Exam_ID = @Exam_ID AND Student_ID = @Student_ID;

    SELECT @MaxDegree = Max_Degree
    FROM Exam
    WHERE Exam_ID = @Exam_ID;

    SET @Percentage = (CAST(@TotalMarks AS DECIMAL(5, 2)) / @MaxDegree) * 100;
    
    RETURN @Percentage;
END;
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[Branch_ID] [int] NOT NULL,
	[B_Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intake]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intake](
	[Int_id] [int] NOT NULL,
	[Int_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Int_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[Track_id] [int] NOT NULL,
	[T_name] [varchar](255) NOT NULL,
	[Intake_id] [int] NOT NULL,
	[Branch_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Track_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[T_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Student_ID] [int] NOT NULL,
	[St_name] [nvarchar](100) NOT NULL,
	[St_Email] [nvarchar](100) NOT NULL,
	[Track_ID] [int] NULL,
	[Intake_ID] [int] NULL,
	[Branch_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[St_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StudentDetails]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StudentDetails] AS
SELECT 
    S.Student_ID,
    S.St_name,
    S.St_Email,
    T.T_name AS TrackName,
    I.Int_name AS IntakeName,
    B.B_Name AS BranchName
FROM Student S
JOIN Track T ON S.Track_ID = T.Track_id
JOIN Intake I ON S.Intake_ID = I.Int_id
JOIN Branch B ON S.Branch_ID = B.Branch_ID;
GO
/****** Object:  Table [dbo].[Ex_Result]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ex_Result](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[Exam_ID] [int] NULL,
	[Student_ID] [int] NULL,
	[Q_ID] [int] NULL,
	[StudentAnswer] [nvarchar](max) NULL,
	[CorrectAnswer] [nvarchar](max) NULL,
	[IsCorrect] [bit] NULL,
	[Mark] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ExamResultsView]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ExamResultsView] AS
SELECT 
    ER.Exam_ID,
    ER.Student_ID,
    S.St_name,
    SUM(ER.Mark) AS TotalMarks
FROM Ex_Result ER
JOIN Student S ON ER.Student_ID = S.Student_ID
GROUP BY ER.Exam_ID, ER.Student_ID, S.St_name;
GO
/****** Object:  Table [dbo].[Contain]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contain](
	[Exam_ID] [int] NOT NULL,
	[Q_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Exam_Question] UNIQUE NONCLUSTERED 
(
	[Exam_ID] ASC,
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Course_ID] [int] NOT NULL,
	[C_name] [nvarchar](100) NULL,
	[C_Discription] [nvarchar](255) NULL,
	[Max_degree] [int] NULL,
	[Min_degree] [int] NULL,
	[Track_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EX_Crc]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EX_Crc](
	[Exam_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[Exam_ID] [int] NOT NULL,
	[Exam_Type] [nvarchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[Start_Time] [time](7) NOT NULL,
	[End_Time] [time](7) NOT NULL,
	[Total_Time] [int] NOT NULL,
	[Allowance_Options] [nvarchar](50) NULL,
	[Max_Degree] [int] NULL,
	[Course_ID] [int] NULL,
	[Instructor_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam_Question]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam_Question](
	[EQ_ID] [int] NOT NULL,
	[Exam_ID] [int] NULL,
	[Q_ID] [int] NULL,
	[Degree_Assigned] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EQ_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[Ins_ID] [int] NOT NULL,
	[Ins_name] [nvarchar](100) NOT NULL,
	[Ins_Email] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ins_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Ins_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participates]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participates](
	[Student_ID] [int] NOT NULL,
	[Exam_ID] [int] NOT NULL,
	[Participation_Date] [date] NOT NULL,
	[Course_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Q_ID] [int] NOT NULL,
	[Q_Type] [nvarchar](50) NOT NULL,
	[Q_Text] [nvarchar](255) NOT NULL,
	[Correct_Answer] [text] NOT NULL,
	[Instructor_ID] [int] NOT NULL,
 CONSTRAINT [PK__Question__F4FC372E3D97FE4C] PRIMARY KEY CLUSTERED 
(
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[st_answer]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[st_answer](
	[Answer_ID] [int] NOT NULL,
	[Answer] [text] NULL,
	[Is_Correct] [bit] NULL,
	[Marks_obtained] [decimal](5, 2) NULL,
	[EQ_ID] [int] NULL,
	[St_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Answer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Takes]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Takes](
	[Student_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teaches]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teaches](
	[Ins_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Ins_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Training_Manager]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Training_Manager](
	[MGR_ID] [int] NOT NULL,
	[MGR_Name] [nvarchar](100) NOT NULL,
	[MGR_Email] [nvarchar](100) NOT NULL,
	[Branch_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MGR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MGR_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [idx_Contains_Exam_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Contains_Exam_ID] ON [dbo].[Contain]
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Contains_Question_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Contains_Question_ID] ON [dbo].[Contain]
(
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Course_Track_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Course_Track_ID] ON [dbo].[Course]
(
	[Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Ex_Result_Exam_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Ex_Result_Exam_ID] ON [dbo].[Ex_Result]
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Ex_Result_Question_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Ex_Result_Question_ID] ON [dbo].[Ex_Result]
(
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Ex_Result_Student_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Ex_Result_Student_ID] ON [dbo].[Ex_Result]
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Exam_Course_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Exam_Course_ID] ON [dbo].[Exam]
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Exam_Question_Exam_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Exam_Question_Exam_ID] ON [dbo].[Exam_Question]
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Exam_Question_Question_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Exam_Question_Question_ID] ON [dbo].[Exam_Question]
(
	[Q_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Participates_Exam_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Participates_Exam_ID] ON [dbo].[Participates]
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Participates_Participation_Date]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Participates_Participation_Date] ON [dbo].[Participates]
(
	[Participation_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Participates_Student_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Participates_Student_ID] ON [dbo].[Participates]
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Question_Course_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Question_Course_ID] ON [dbo].[Question]
(
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_Question_Question_Type]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Question_Question_Type] ON [dbo].[Question]
(
	[Q_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_st_answer_Student_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_st_answer_Student_ID] ON [dbo].[st_answer]
(
	[St_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Student_Track_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Student_Track_ID] ON [dbo].[Student]
(
	[Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Takes_Course_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Takes_Course_ID] ON [dbo].[Takes]
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Takes_Student_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Takes_Student_ID] ON [dbo].[Takes]
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Teaches_Course_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Teaches_Course_ID] ON [dbo].[Teaches]
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Teaches_Instructor_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Teaches_Instructor_ID] ON [dbo].[Teaches]
(
	[Ins_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Track_Branch_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Track_Branch_ID] ON [dbo].[Track]
(
	[Branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_Training_Manager_Branch_ID]    Script Date: 28/08/2024 04:16:31 م ******/
CREATE NONCLUSTERED INDEX [idx_Training_Manager_Branch_ID] ON [dbo].[Training_Manager]
(
	[Branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contain]  WITH CHECK ADD FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Contain]  WITH CHECK ADD  CONSTRAINT [FK__Contain__Q_ID__6A30C649] FOREIGN KEY([Q_ID])
REFERENCES [dbo].[Question] ([Q_ID])
GO
ALTER TABLE [dbo].[Contain] CHECK CONSTRAINT [FK__Contain__Q_ID__6A30C649]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([Track_id])
GO
ALTER TABLE [dbo].[EX_Crc]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[EX_Crc]  WITH CHECK ADD FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Ex_Result]  WITH CHECK ADD FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Ex_Result]  WITH CHECK ADD  CONSTRAINT [FK__Ex_Result__Q_ID__74AE54BC] FOREIGN KEY([Q_ID])
REFERENCES [dbo].[Question] ([Q_ID])
GO
ALTER TABLE [dbo].[Ex_Result] CHECK CONSTRAINT [FK__Ex_Result__Q_ID__74AE54BC]
GO
ALTER TABLE [dbo].[Ex_Result]  WITH CHECK ADD FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK__Exam_Quest__Q_ID__5441852A] FOREIGN KEY([Q_ID])
REFERENCES [dbo].[Question] ([Q_ID])
GO
ALTER TABLE [dbo].[Exam_Question] CHECK CONSTRAINT [FK__Exam_Quest__Q_ID__5441852A]
GO
ALTER TABLE [dbo].[Participates]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Participates]  WITH CHECK ADD FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Participates]  WITH CHECK ADD FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Participates]  WITH CHECK ADD  CONSTRAINT [FK_Student_Course] FOREIGN KEY([Student_ID], [Course_ID])
REFERENCES [dbo].[Takes] ([Student_ID], [Course_ID])
GO
ALTER TABLE [dbo].[Participates] CHECK CONSTRAINT [FK_Student_Course]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK__Question__Instru__49C3F6B7] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK__Question__Instru__49C3F6B7]
GO
ALTER TABLE [dbo].[st_answer]  WITH CHECK ADD FOREIGN KEY([EQ_ID])
REFERENCES [dbo].[Exam_Question] ([EQ_ID])
GO
ALTER TABLE [dbo].[st_answer]  WITH CHECK ADD FOREIGN KEY([St_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([Branch_ID])
REFERENCES [dbo].[Branch] ([Branch_ID])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([Intake_ID])
REFERENCES [dbo].[Intake] ([Int_id])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([Track_id])
GO
ALTER TABLE [dbo].[Takes]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Takes]  WITH CHECK ADD FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Teaches]  WITH CHECK ADD FOREIGN KEY([Ins_ID])
REFERENCES [dbo].[Instructor] ([Ins_ID])
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD FOREIGN KEY([Branch_id])
REFERENCES [dbo].[Branch] ([Branch_ID])
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD FOREIGN KEY([Intake_id])
REFERENCES [dbo].[Intake] ([Int_id])
GO
ALTER TABLE [dbo].[Training_Manager]  WITH CHECK ADD FOREIGN KEY([Branch_ID])
REFERENCES [dbo].[Branch] ([Branch_ID])
GO
/****** Object:  StoredProcedure [dbo].[AddExamResult]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddExamResult]
    @Exam_ID INT,
    @Student_ID INT,
    @Q_ID INT,
    @StudentAnswer NVARCHAR(MAX),
    @CorrectAnswer NVARCHAR(MAX),
    @IsCorrect BIT,
    @Mark INT
AS
BEGIN
    INSERT INTO Ex_Result (Exam_ID, Student_ID, Q_ID, StudentAnswer, CorrectAnswer, IsCorrect, Mark)
    VALUES (@Exam_ID, @Student_ID, @Q_ID, @StudentAnswer, @CorrectAnswer, @IsCorrect, @Mark);
END;
GO
/****** Object:  StoredProcedure [dbo].[AddStudent]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddStudent]
    @St_name NVARCHAR(100),
    @St_Email NVARCHAR(100),
    @Track_ID INT,
    @Intake_ID INT,
    @Branch_ID INT
AS
BEGIN
    INSERT INTO Student (St_name, St_Email, Track_ID, Intake_ID, Branch_ID)
    VALUES (@St_name, @St_Email, @Track_ID, @Intake_ID, @Branch_ID);
END;
GO
/****** Object:  StoredProcedure [dbo].[CalculateExamResult]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CalculateExamResult]
    @Exam_ID INT,
    @Student_ID INT
AS
BEGIN
    DECLARE @TotalMarks INT;

    SELECT @TotalMarks = SUM(Mark)
    FROM Ex_Result
    WHERE Exam_ID = @Exam_ID AND Student_ID = @Student_ID;

    PRINT 'Total Marks for Exam ' + CAST(@Exam_ID AS NVARCHAR) + ' for Student ' + CAST(@Student_ID AS NVARCHAR) + ' is: ' + CAST(@TotalMarks AS NVARCHAR);
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateStudent]    Script Date: 28/08/2024 04:16:31 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStudent]
    @Student_ID INT,
    @St_name NVARCHAR(100),
    @St_Email NVARCHAR(100),
    @Track_ID INT,
    @Intake_ID INT,
    @Branch_ID INT
AS
BEGIN
    UPDATE Student
    SET St_name = @St_name,
        St_Email = @St_Email,
        Track_ID = @Track_ID,
        Intake_ID = @Intake_ID,
        Branch_ID = @Branch_ID
    WHERE Student_ID = @Student_ID;
END;
GO
USE [master]
GO
ALTER DATABASE [Examination_System] SET  READ_WRITE 
GO
