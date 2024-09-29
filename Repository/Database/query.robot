*** Variables   ***
#-------------------- Query Customer Account and Billing Account ---------------------------#
${SFF_CA_Number_Query}           select a.accnt_no from sff_asset_instance ai, sff_account a where ai.accnt_id = a.row_id and ai.mobile_no in ('???') ORDER BY ai.LAST_UPD DESC
${SFF_BA_Number_Query}           select a.accnt_no from sff_asset_instance ai, sff_account a where ai.billing_accnt_id = a.row_id and ai.mobile_no in ('???') ORDER BY ai.LAST_UPD DESC
${SFF_IRB_Prod_Sequence_Query}             select a.gv_prod_seq, a.imsi, a.* from sff_asset_instance a where a.mobile_no in ('???') order by a.start_dt desc

${SFF_Status_Number_Query}        select a.status_cd,a.data_charging_system from sff_asset_instance a where a.mobile_no in ('???') ORDER BY a.LAST_UPD DESC
${SFF_Billing_System_Query}         select a.BILLING_SYSTEM from sff_asset_instance ai, sff_account a where ai.billing_accnt_id = a.row_id and ai.mobile_no in ('???') ORDER BY a.LAST_UPD DESC
${SFF_Promotion_Query}       select p.product_name,api.status_cd , p.product_class from sff_asset_promotion_item api, sff_asset_instance ai, sff_product p where api.asset_instance_id = ai.row_id and api.promotion_id = p.row_id and  p.product_class = 'Main' and api.status_cd = 'Active' and ai.mobile_no in ('???') ORDER BY ai.LAST_UPD DESC
${SFF_Service_Query}        select p.product_name, api.status_cd from sff_asset_service_item api, sff_asset_instance ai, sff_product p where api.asset_instance_id = ai.row_id and api.product_id = p.row_id and api.status_cd = 'Active' and ai.mobile_no in ('???')
${SFF_Acc_Cate_Query}      select a.rowid,  a.ACCNT_CATEGORY, a.ACCNT_SUB_CATEGORY from sff_account a where a.ACCNT_NO in ('???')

${SFF_Sim_Serial_No_Query}                             select a.sim_serial_no from sff_asset_instance a where a.mobile_no in ('???') order by a.start_dt desc
${Order_Fee_Query}                                     select * from sff_ar_order a where a.billing_accnt_id = (select ai.billing_accnt_id from sff_asset_instance ai where (ai.status_cd = 'Active' or ai.status_cd like 'Suspend%') and ai.mobile_no = '0893647863') and (a.deleted_flg = 'N' or a.deleted_flg is null) and (a.Billed_Flg = 'N' or a.Billed_Flg is null) and (a.Extracted_Flg = 'N' or a.Extracted_Flg is null) and (a.Reconnect_Fee_Flg = 'N' or a.Reconnect_Fee_Flg is null)

#------------------------------- Verify SFF ------------------------------#
${SFF_Order_Head_Tail_Status_Query}    select o.status_cd, osi.status_cd, o.order_type from sff_order o, sff_order_service_instance osi where o.row_id = osi.order_id and o.order_no = '???'
${SFF_Order_SFF_asset_instance}        select a.status_cd,a.status_reason, a.suspend_type from sff_asset_instance a where a.mobile_no in ('???')
${SFF_Order_Reason_Hist_Query}       select osi.status_reason from sff_order o, sff_order_service_instance osi where o.row_id = osi.order_id and o.order_no = ('???')

#----------------------------- EAI --------------------------------#
${EAI_query_orderlist}      select a.ORDER_TYPE, a.STATUS_CD, a.RESPONSE_STATUS_CD  FROM eaiadm.sff_tbl_track_order a WHERE a.ROW_ID = ('???')
${EAI_query_task}       select a.ORIGIN_ORDER_TYPE, a.STATUS_CD, a.RESPONSE_STATUS_CD FROM eaiadm.sff_tbl_track_service_instance a WHERE a.ORDER_NO = ('???')
${EAI_sync_list}       select a.DESTINATION, a.STATUS_CD FROM sff_tbl_sync_header a WHERE a.ORDER_NO = ('???')

#---------------------------- RPM ---------------------------------#
${SFF_Prod_Status_Query}        SELECT * FROM custproductstatus WHERE customer_ref = '???' and product_seq = '///' and PRODUCT_STATUS = '&&&' Order by effective_dtm desc fetch first 1 row only


#----------------- SFF Product --------
${SFF_Product_name}             select * from sff_product where product_name = ('???')
${SFF_Integration_name}             select integration_name from sff_product where product_name = ('???')
${sff_start_date}       SELECT TO_CHAR(API.END_DT, 'DD/MM/YYYY HH24:MI:SS') FROM sff_asset_promotion_item api, sff_asset_instance ai, sff_product p WHERE api.asset_instance_id = ai.row_id and api.promotion_id = p.row_id and  p.product_class = ('///') and api.status_cd = 'Active' and ai.mobile_no in ('???') ORDER BY api.LAST_UPD DESC
${SFF_Integration_name_offering}    select integration_name from sff_product where phx_product_id in ('???')
${SFF_Int_name_w_product_cd}             select integration_name from sff_product where product_cd = ('???')
#---------------------------- SKY ---------------------------------#
#New Register
${SKY_CDD_Override_Value}       select output from mponewcddadm.mponewcdd_override_value where key1 = '???'
${SKY_COD_Override_Value}       select output from mponewcodadm.mponewcod_override_value where key1 = '???'
${SKY_Override_productcode}      select a.KEY1  from mponewcddadm.mponewcdd_override_value a WHERE  a.OUTPUT = ('???') AND a.KEY0 = ('sffProductNameToProductSpecId')

#Disconnect Terminated
${SKY_CDD_Override_Value_Terminate}       select output from mpodiscddadm.mpodiscdd_override_value where key1 = '???'
${SKY_COD_Override_Value_Terminate}       select output from mpodiscodadm.mpodiscod_override_value where key1 = '???'

#----------------------------- Update mobile and sim --------------------------#
${INVPVT_Update_Number_Status_To_Available_Query}      update sff_number a set a.status_cd = 'Available' ,a.prev_status_cd = 'Cancelled' where a.mobile_no = '???'
${INVPVT_Update_SIM_Status_To_Available_Query}         update sff_sim set status_cd = 'Available' ,prev_status_cd = 'Cancelled' where serial_no = '???'

${SFF_Sim_Serial_No_Query}        select a.sim_serial_no from sff_asset_instance a where a.mobile_no in ('???') order by a.start_dt desc
