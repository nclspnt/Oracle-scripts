set lines 200 pages 200
col name format a75
col value format 999999999999999999999999999

-- smartscan performance
select NAME, VALUE/1024/1024/1024/1024 TB from v$SYSSTAT where name in ( 'cell physical IO bytes saved by storage index', 'physical read total bytes', 'cell physical IO bytes eligible for predicate offload' ) ;

-- systats available
select NAME, VALUE/1024/1024 MB from v$SYSSTAT where name like 'cell%' order by 1 ;

-- from cellcli, all metriccurrent 
LIST METRICDEFINITION attributes name, metricType, description order by metricType

CellCLI> LIST METRICDEFINITION attributes name, metricType, description where metricType = 'Instantaneous'  order by name


-- list I/O request par consumer group
list metriccurrent CG_FC_IO_RQ

CellCLI> list metriccurrent DB_FL_IO_RQ_SEC
         DB_FL_IO_RQ_SEC         ARAPRD                  6.350 IO/sec
         DB_FL_IO_RQ_SEC         ARISPRD                 2.050 IO/sec
         DB_FL_IO_RQ_SEC         ASM                     0.000 IO/sec
         DB_FL_IO_RQ_SEC         CODAPRD                 4.067 IO/sec
         DB_FL_IO_RQ_SEC         ENOVPRD                 4.067 IO/sec
         DB_FL_IO_RQ_SEC         INCAPRD                 4.100 IO/sec
         DB_FL_IO_RQ_SEC         INRCUPRD                0.000 IO/sec
         DB_FL_IO_RQ_SEC         O12TEC                  0.000 IO/sec
         DB_FL_IO_RQ_SEC         PIVOTPRD                123 IO/sec
         DB_FL_IO_RQ_SEC         RFXPRD                  4.483 IO/sec
         DB_FL_IO_RQ_SEC         SAGPRD                  2,348 IO/sec
         DB_FL_IO_RQ_SEC         SASPRD                  4.300 IO/sec
         DB_FL_IO_RQ_SEC         VEKATXT                 0.033 IO/sec
         DB_FL_IO_RQ_SEC         _OTHER_DATABASE_        0.533 IO/sec


CellCLI> list metriccurrent CG_FC_IO_RQ
         CG_FC_IO_RQ     ARAPRD.ORA$AUTOTASK                             1,029 IO requests
         CG_FC_IO_RQ     ARAPRD.OTHER_GROUPS                             11 IO requests
         CG_FC_IO_RQ     ARAPRD.SYS_GROUP                                12 IO requests
         CG_FC_IO_RQ     ARAPRD._ORACLE_BACKGROUND_GROUP_                96,800 IO requests
         CG_FC_IO_RQ     ARAPRD._ORACLE_LOWPRIBG_GROUP_                  16,876 IO requests
         CG_FC_IO_RQ     ARAPRD._ORACLE_LOWPRIFG_GROUP_                  0 IO requests
         CG_FC_IO_RQ     ARAPRD._ORACLE_MEDPRIBG_GROUP_                  16 IO requests

nombre de MB alloués dans le FC par base
		 
CellCLI> list metriccurrent DB_FC_BY_ALLOCATED
         DB_FC_BY_ALLOCATED      ARAPRD                  3,756 MB
         DB_FC_BY_ALLOCATED      ARISPRD                 1,722 MB
         DB_FC_BY_ALLOCATED      ASM                     0.000 MB
         DB_FC_BY_ALLOCATED      CODAPRD                 154,742 MB
         DB_FC_BY_ALLOCATED      ENOVPRD                 1,318 MB
         DB_FC_BY_ALLOCATED      INCAPRD                 1,629 MB
         DB_FC_BY_ALLOCATED      INRCUPRD                1,246 MB
         DB_FC_BY_ALLOCATED      O12TEC                  763 MB
         DB_FC_BY_ALLOCATED      PIVOTPRD                573,987 MB
         DB_FC_BY_ALLOCATED      RFXPRD                  3,245 MB
         DB_FC_BY_ALLOCATED      SAGPRD                  1,082,699 MB
         DB_FC_BY_ALLOCATED      SASPRD                  1,489 MB
         DB_FC_BY_ALLOCATED      VEKATXT                 425 MB
         DB_FC_BY_ALLOCATED      _OTHER_DATABASE_        4,382 MB

		 
-- space used in FC
CellCLI> list metriccurrent FC_BY_USED
         FC_BY_USED      FLASHCACHE      1,747,991 MB

-- list objects KEEP in FC
CellCLI> list metriccurrent FC_BYKEEP_USED
         FC_BYKEEP_USED  FLASHCACHE      0.000 MB

		 
		 






		 