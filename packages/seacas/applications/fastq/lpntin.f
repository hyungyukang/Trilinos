C    Copyright(C) 1999-2020 National Technology & Engineering Solutions
C    of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C    NTESS, the U.S. Government retains certain rights in this software.
C    
C    See packages/seacas/LICENSE for details

C $Id: lpntin.f,v 1.1 1990/11/30 11:11:30 gdsjaar Exp $
C $Log: lpntin.f,v $
C Revision 1.1  1990/11/30 11:11:30  gdsjaar
C Initial revision
C
C
CC* FILE: [.QMESH]LPNTIN.FOR
CC* MODIFIED BY: TED BLACKER
CC* MODIFICATION DATE: 7/6/90
CC* MODIFICATION: COMPLETED HEADER INFORMATION
C
      LOGICAL FUNCTION LPNTIN (MAXNP, CX, CY, NPNT, X, Y)
C***********************************************************************
C
C  FUNCTION LPNTIN = .TRUE. IF THE POINT IS WITHIN THE PERIMETER
C
C***********************************************************************
C
      LOGICAL IN
      REAL CX(MAXNP), CY(MAXNP), X, Y
C
      I1 = 1
      IN = .TRUE.
  100 CONTINUE
      IF (I1 .LE. NPNT .AND. IN) THEN
         IF (I1 .EQ. NPNT) THEN
            I2 = 1
         ELSE
            I2 = I1 + 1
         END IF
C
C  CHECK FOR VERTICAL LINE
         IF (ABS(CX(I1) - CX(I2)) .LT. 1.0E-06) THEN
            IF (CY(I1) .LT. CY(I2)) THEN
               IN = X .LT. CX(I2)
            ELSE
               IN = X .GT. CX(I2)
            END IF
C
C  CHECK FOR HORIZONTAL LINE
         ELSE IF (ABS(CY(I1) - CY(I2)) .LT. 1.0E-06) THEN
            IF (CX(I1) .LT. CX(I2)) THEN
               IN = Y .GT. CY(I2)
            ELSE
               IN = Y .LT. CY(I2)
            END IF
C
C  MUST BE INCLINED LINE
         ELSE
            U = (X - CX(I1))/(CX(I2) - CX(I1))
            U = MIN(U, 1.0)
            U = MAX(0.0, U)
            V = (Y - CY(I1))/(CY(I2) - CY(I1))
            V = MIN(V, 1.0)
            V = MAX(0.0, V)
            IF (CX(I1) .LT. CX(I2)) THEN
               IF (CY(I1) .LT. CY(I2)) THEN
                  IN = U .LE. V
               ELSE
                  IN = U .GE. V
               END IF
            ELSE
               IF (CY(I1) .GT. CY(I2)) THEN
                  IN = U .LE. V
               ELSE
                  IN = U .GE. V
               END IF
            END IF
         END IF
C
         I1 = I1 + 1
         GO TO 100
      END IF
      LPNTIN = IN
C
      RETURN
      END
