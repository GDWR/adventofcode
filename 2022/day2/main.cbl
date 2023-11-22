        IDENTIFICATION Division.
            PROGRAM-ID.     Aoc2022Day7Part2.
            AUTHOR          "GDWR"
            DATE-WRITTEN    "07-12-22"

        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.

            SELECT DATA-FILE ASSIGN TO "./data"
                ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.
        FILE SECTION.
        FD DATA-FILE.
        01 IN-RECORD.
            02 OPPONENT-CHOICE PIC X(1).
            02 SPACER          PIC X(1).
            02 MY-CHOICE       PIC X(1).

        WORKING-STORAGE SECTION.
        01 END-OF-FILE  PIC Z(1).
        01 COUNTER      PIC 9(4) VALUE 0.
        01 SCORE1       PIC 9(10) VALUE 0.
        01 SCORE2       PIC 9(10) VALUE 0.

        PROCEDURE DIVISION.
        BEGIN.
            OPEN INPUT DATA-FILE.

            PERFORM UNTIL END-OF-FILE = 1
                READ DATA-FILE
                    AT END MOVE 1 TO END-OF-FILE
                    NOT AT END
                        COMPUTE COUNTER = COUNTER + 1

                        EVALUATE OPPONENT-CHOICE
                            WHEN "A"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE1 = SCORE1 + 1 + 3
                                        COMPUTE SCORE2 = SCORE2 + 3 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE1 = SCORE1 + 2 + 6
                                        COMPUTE SCORE2 = SCORE2 + 1 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE1 = SCORE1 + 3 + 0
                                        COMPUTE SCORE2 = SCORE2 + 2 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN "B"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE1 = SCORE1 + 1 + 0
                                        COMPUTE SCORE2 = SCORE2 + 1 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE1 = SCORE1 + 2 + 3
                                        COMPUTE SCORE2 = SCORE2 + 2 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE1 = SCORE1 + 3 + 6
                                        COMPUTE SCORE2 = SCORE2 + 3 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN "C"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE1 = SCORE1 + 1 + 6
                                        COMPUTE SCORE2 = SCORE2 + 2 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE1 = SCORE1 + 2 + 0
                                        COMPUTE SCORE2 = SCORE2 + 3 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE1 = SCORE1 + 3 + 3
                                        COMPUTE SCORE2 = SCORE2 + 1 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN OTHER
                                DISPLAY "Invalid"
                END-READ
          END-PERFORM

          DISPLAY "Part one >>> " SCORE1
          DISPLAY "Part two >>> " SCORE2

          CLOSE DATA-FILE
       STOP RUN.
