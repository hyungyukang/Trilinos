C Copyright(C) 1999-2020 National Technology & Engineering Solutions
C of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C NTESS, the U.S. Government retains certain rights in this software.
C 
C See packages/seacas/LICENSE for details

C $Log: dtchk.f,v $
C Revision 1.3  2009/03/25 12:36:43  gdsjaar
C Add copyright and license notice to all files.
C Permission to assert copyright has been granted; blot is now open source, BSD
C
C Revision 1.2  2009/01/22 21:34:21  gdsjaar
C There were several inline dbnums common blocks. Replaced with the
C include so they all have the same size with the added variable types.
C
C Added minor support for nodeset and sideset variables.
C
C It can print the count and the names, but that is all
C at this time.
C
C Revision 1.1  1994/04/07 19:59:39  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:49:28  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE DTCHK (PRTOK, OKAY)
C=======================================================================

C   --*** DTCHK *** (DETOUR) Check that DETOUR is a valid program to run
C   --   Written by Amy Gilkey - revised 10/23/87
C   --
C   --DTCHK checks that DETOUR is a valid program.  This is true if
C   --a mesh is defined (nodes, elements, connectivity, etc.).
C   --
C   --If the program is valid, a welcome message is printed.
C   --
C   --Parameters:
C   --   PRTOK - IN - if true, print error messages and welcome messages,
C   --      if false, check but do not print anything
C   --   OKAY - OUT - true iff the program is valid
C   --
C   --Common Variables:
C   --   Uses NDIM, NUMNP, NUMEL of /DBNUMS/

      include 'dbnums.blk'

      LOGICAL PRTOK
      LOGICAL OKAY

C   --Check header information from database

      IF ((NUMNP .LE. 0) .OR. (NUMEL .LE. 0) .OR. (NDIM .LE. 0)) THEN
         IF (PRTOK) CALL PRTERR ('CMDERR',
     &      'No mesh is defined')
         GOTO 100
      END IF
      IF ((NDIM .NE. 2) .AND. (NDIM .NE. 3)) THEN
         IF (PRTOK) CALL PRTERR ('CMDERR',
     &      'Only a 2D or 3D mesh may be plotted')
         GOTO 100
      END IF

C   --Write greeting message
      IF (PRTOK) WRITE (*, 10000)

      OKAY = .TRUE.
      RETURN

  100 CONTINUE
      OKAY = .FALSE.
      RETURN
10000  FORMAT (' DETOUR - a deformed mesh and contour plot program')
      END
