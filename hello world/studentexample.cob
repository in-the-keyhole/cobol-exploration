IDENTIFICATION DIVISION.
PROGRAM-ID.  SeqWriteRead.
AUTHOR.  Michael Coughlan.


ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT StudentFile ASSIGN TO "STUDENTS.DAT"
		ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD StudentFile.
01 StudentRec.
   88  EndOfStudentFile  VALUE HIGH-VALUES.
   02  StudentId         PIC 9(7).
   02  StudentName.
       03 Surname        PIC X(8).
       03 Initials       PIC XX.
   02  DateOfBirth.
       03 YOBirth        PIC 9(4).
       03 MOBirth        PIC 9(2).
       03 DOBirth        PIC 9(2).
   02  CourseCode        PIC X(4).
   02  Gender            PIC X.

PROCEDURE DIVISION.
Begin.
    OPEN OUTPUT StudentFile
    DISPLAY "Enter student details using template below."
    DISPLAY "Enter no data to end"

    PERFORM GetStudentRecord
    PERFORM UNTIL StudentRec = SPACES
       WRITE StudentRec
       PERFORM GetStudentRecord
    END-PERFORM
    CLOSE StudentFile

    OPEN INPUT StudentFile.
    READ StudentFile
         AT END SET EndOfStudentFile TO TRUE
    END-READ
    PERFORM UNTIL EndOfStudentFile
       DISPLAY StudentId SPACE StudentName SPACE CourseCode
       READ StudentFile
            AT END SET EndOfStudentFile TO TRUE
       END-READ
    END-PERFORM
    CLOSE StudentFile
    STOP RUN.

GetStudentRecord.
    DISPLAY "NNNNNNNSSSSSSSSIIYYYYMMDDCCCCG"
    ACCEPT  StudentRec.