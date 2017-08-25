set lines 200 pages 200
col name format a75
col value format 999999999999999999999999999

-- smartscan performance
select NAME, VALUE from v$SYSSTAT where name like 'cell%' order by 2 desc ;

select NAME, VALUE/1024/1024/1024/1024 TB from v$SYSSTAT where name in ( 'cell physical IO bytes saved by storage index', 'physical read total bytes', 'cell physical IO bytes eligible for predicate offload' ) ;


-- safely shutdown a cell 
cellcli -e LIST GRIDDISK attributes name, status, asmmodestatus, asmdeactivationoutcome
cellcli -e ALTER GRIDDISK ALL INACTIVE
cellcli -e LIST GRIDDISK attributes name, status, asmmodestatus, asmdeactivationoutcome
shutdown -h -y now

-- safely start a cell 
cellcli -e ALTER GRIDDISK ALL ACTIVE
cellcli -e LIST GRIDDISK attributes name, status, asmmodestatus, asmdeactivationoutcome


-- safely change an HARDDRIVE
--> check on ASM asm_power_limit 
LIST ALERTHISTORY WHERE ALERTMESSAGE LIKE "Logical drive lost.*" DETAIL
--> output with the HDD id  20:5
ALTER PHYSICALDISK 20:5 SERVICELED ON
--> Une fois que vous avez identifié le disque posant problème, vous pouvez le remplacer. Lors du retrait du disque, une alerte est générée. Lorsqu'un disque physique est installé, il doit être reconnu par le contrôleur RAID pour pouvoir être utilisé. La procédure n'est pas longue et vous pouvez utiliser la commande LIST PHYSICALDISK pour surveiller l'état jusqu'à ce qu'il reprenne la valeur NORMAL.
LIST PHYSICALDISK
--> monitoring on GV$ASM_OPERATION (error, etc)

-- safely change an FLASHDRIVE
--> INFO = Bien que les cartes PCI d'un serveur Exadata Storage Server soient techniquement remplaçables à chaud, il est recommandé de mettre la cellule hors tension lors du remplacement d'une carte Flash endommagée. 
--> 1 . Identifiez la carte Flash endommagée.
LIST PHYSICALDISK DETAIL
--> 2 . Mettez la cellule hors tension.
--> 3 . Remplacez la carte Flash.
--> 4 . Mettez la cellule sous tension.
--> 5 . Si la carte contenait un disque grille Flash, surveillez ASM pour vérifier que le nouvel ajout du disque a été effectué.



-- systats available
select NAME, VALUE/1024/1024 MB from v$SYSSTAT where name like 'cell%' order by 1 ;

-- from cellcli, all metriccurrent 
LIST METRICDEFINITION attributes name, metricType, description order by metricType

CellCLI> LIST METRICDEFINITION attributes name, objectType,  metricType, description where metricType = 'Instantaneous'  order by name

-- monitoring cell state and its process MS, RS, CELLSRV
./dcli -g cells_all -l root cellcli -e LIST CELL attributes name,cpuCount,cellsrvStatus,msStatus,rsStatus,upTime,powerStatus,ipaddress1,ipaddress2,eighthRack,flashCacheMode

./dcli -g cells_all -l root cellcli -e LIST PHYSICALDISK

./dcli -g cells_all -l root cellcli -e LIST alerthistory

-- current I/Os request monitoring
watch -n 1  ./dcli -g cells_all -l celladmin cellcli -e list ACTIVEREQUEST attributes dbName, fileType, ioGridDisk, ioOffset, ioReason, ioType,requestState, sqlID

./dcli -g cells_all -l celladmin cellcli -e list ALERTHISTORY
dc2lxsn003: 2_1  2017-04-01T07:27:26+02:00       critical        "Flash disk failed.  Status        : FAILED  Manufacturer  : Oracle  Model Number  : Flash Accelerator F320 PCIe Card  Size          : 2981GB  Serial Number : S2T7NAAH404604  Firmware      : KPYABR3Q  Slot Number   : PCI Slot: 2; FDOM: 1  Cell Disk     : FD_00_dc2lxsn003  Grid Disk     : Not configured"
dc2lxsn003: 2_2  2017-05-29T22:21:08+02:00       warning         "Flash disk was removed.  Status        : FAILED  Manufacturer  : Oracle  Model Number  : Flash Accelerator F320 PCIe Card  Size          : 2981GB  Serial Number : S2T7NAAH404604  Firmware      : KPYABR3Q  Slot Number   : PCI Slot: 2; FDOM: 1  Cell Disk     : FD_00_dc2lxsn003  Grid Disk     : Not configured  Flash Cache   : Present  Flash Log     : Present"
dc2lxsn003: 2_3  2017-05-29T22:21:55+02:00       clear           "Flash disk was replaced.  Status        : NORMAL  Manufacturer  : Oracle  Model Number  : Flash Accelerator F320 PCIe Card  Size          : 2981GB  Serial Number : S2T7NAAH200858  Firmware      : KPYAGR3Q  Slot Number   : PCI Slot: 2; FDOM: 1  Cell Disk     : FD_00_dc2lxsn003  Grid Disk     : Not configured  Flash Cache   : Present  Flash Log     : Present"

 ./dcli -g ./db_all -l root dbmcli -e LIST ALERTHISTORY
dc1lxdn002: 1_1  2017-06-17T07:37:49+02:00       critical        "A generic component is suspected of causing a fault with a 100% certainty.  Component Name : /SYS  Fault class    : fault.cpu.intel.timeout  Fault message  : http://www.sun.com/msg/SPX86A-8002-H0"
dc1lxdn002: 1_2  2017-07-04T14:40:10+02:00       clear           "A generic component fault has been cleared.  Component Name       : /SYS  Trap Additional Info : fault.cpu.intel.timeout"
dc1lxdn002: 2_1  2017-08-09T10:15:36+02:00       warning         "Active physical core count was changed successfully. Reboot the machine to make the change effective."



-- Check offset position for griddisk to ensure data are storge on most outer edge of disk
[root@sd02celadm03 ~]# cellcli -e list GRIDDISK attributes asmDiskGroupName,cachedBy,cachingPolicy,offset,size,status
         DATAC1          FD_01_sd02celadm03      default         32M                     2.8837890625T   active
         DATAC1          FD_00_sd02celadm03      default         32M                     2.8837890625T   active
         DATAC1          FD_01_sd02celadm03      default         32M                     2.8837890625T   active
         DATAC1          FD_01_sd02celadm03      default         32M                     2.8837890625T   active
         DATAC1          FD_00_sd02celadm03      default         32M                     2.8837890625T   active
         DATAC1          FD_00_sd02celadm03      default         32M                     2,8837890625T   active
         DBFS_DG         FD_01_sd02celadm03      default         3.6049652099609375T     33.796875G      active
         DBFS_DG         FD_01_sd02celadm03      default         3.6049652099609375T     33.796875G      active
         DBFS_DG         FD_00_sd02celadm03      default         3.6049652099609375T     33.796875G      active
         DBFS_DG         FD_00_sd02celadm03      default         3.6049652099609375T     33.796875G      active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active
         RECOC1                                  none            2.8838348388671875T     738.4375G       active



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

		 
	
-- SmartCache efficiency for a table from queries stats  

select  sql_id,
io_cell_offload_eligible_bytes qualifying,
io_cell_offload_returned_bytes actual,
round(((io_cell_offload_eligible_bytes - io_cell_offload_returned_bytes)/io_cell_offload_eligible_bytes)*100, 2) io_saved_pct,
sql_text
from v$sql
where io_cell_offload_returned_bytes > 0
and instr(lower(sql_fulltext), 'tst_nclspnt_01') > 0
;




		 