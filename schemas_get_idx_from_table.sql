@display_configuration.sql
break ON index_name skip 1
 

SELECT c.index_name, i.INDEX_TYPE, i.uniqueness, i.STATUS,  i.LAST_ANALYZED,  i.NUM_ROWS,  i.DISTINCT_KEYS, i.BLEVEL, i.LEAF_BLOCKS, i.AVG_LEAF_BLOCKS_PER_KEY, i.AVG_DATA_BLOCKS_PER_KEY, i.VISIBILITY, c.COLUMN_POSITION, c.column_name
FROM   dba_indexes i, dba_ind_columns c
WHERE  i.index_name = c.index_name
  AND  i.owner = c.index_owner
  AND  i.table_name = UPPER('&table_name.')
  AND  i.owner = UPPER('&owner.')
ORDER  BY c.index_name, c.column_position
/

undef 1
