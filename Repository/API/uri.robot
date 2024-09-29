*** Variables ***

########################### URL for Post to getting Responses  ##################################
${HLR_API_URL}         http://10.138.21.226:42003/Resources/v1/Fulfillment/synchronous/ServiceProvisioning
${USMP_API_URL}        http://10.138.21.226:42003/Resources/v1/Fulfillment/synchronous/ServiceProvisioning
${CBS_API_URL}         http://10.138.21.226:42003/Resources/v1/Fulfillment/synchronous/ServiceProvisioning



############################# ------- (API) Request to Get Token -------##########################################
@{api_header}               Content-Type=application/json;charset=utf-8
${host_url}                 https://test-sky.intra.ais:2443   #IOT
#${host_url}                 https://test-sky.intra.ais:443          #E2E
${get_token_url}            /sky-auth/v1/user/authenticate
${post_order_suspend_url}   ${host_url}/fbb/suspend/conductor/v1/order
${get_token_body}           {"username": "hk_usr", "password": "ebb1345b837c3039d16e9c0675cc449a"}

############################# ------- (API) Request URL for Request Order  -------##########################################

${New_URL_Request_Order}       https://phxdev-nginx1.intra.ais:2443/fbb/???/conductor/v1/order

############################# ------- (API) Request URL for Verify SKY Status  -------##########################################
${Assign_Url}      https://phxdev-nginx1.intra.ais:2443/fbb/???/customer-order/v1/tasks/AIS
${get_conductor_url}            ${host_url}/fbb/???/conductor/v1/order/AIS
${get_conductor_task_url}       ${host_url}/fbb/???/conductor/v1/tasks/AIST001
${get_CusOrder_Instances_url}   ${host_url}/fbb/???/customer-order/v1/order/AIS
${get_CusOrder_task_url}        ${host_url}/fbb/???/customer-order/v1/tasks/AIS

${get_CusOrder_task_url_register}        ${host_url}/fbb/register/customer-order/v1/tasks/
${get_CusOrder_Instances_url_register}   ${host_url}/fbb/register/customer-order/v1/order/AIS
${get_conductor_task_url_register}       ${host_url}/fbb/register/conductor/v1/tasks/AIST001
${get_conductor_url_register}            ${host_url}/fbb/register/conductor/v1/order/AIS

############################ Files Json For API ####################################
${json_path_HLR}            ../ResourcesNew/Variables/common_hlr_body.json
${json_path_USMP}           ../ResourcesNew/Variables/common_usmp_body.json
${json_path_CBS}            ../ResourcesNew/Variables/common_cbs_body.json

# ------- Disconnect --------#
${Assign_Url_terminate}                   ${host_url}/fbb/disconnect/conductor/v1/order
${get_conductor_url_terminate}            ${host_url}/fbb/disconnect/conductor/v1/order/AIS
${get_conductor_task_url_terminate}       ${host_url}/fbb/disconnect/conductor/v1/tasks/AIST001
${get_CusOrder_Instances_url_terminate}   ${host_url}/fbb/disconnect/customer-order/v1/order/AIS
${get_CusOrder_task_url_terminate}        ${host_url}/fbb/disconnect/customer-order/v1/tasks/

${get_cod_task_test}            ${host_url}/fbb/disconnect/customer-order/v1/tasks?instanceId=AIST00N

${get_cusorder_all_task_cpo}   ${host_url}/fbb/disconnect/customer-order/v1/tasks?instanceId=
${get_sub_instances_url_cpo}   ${host_url}/fbb/disconnect/subscriber/v1/instance?privateIdValue=
${get_svd_instances_url_cpo}   ${host_url}/fbb/disconnect/service-order/v1/services?privateIdValue=
${get_coa_instances_url_cpo}   ${host_url}/fbb/disconnect/order-acceptance/v1/order?privateIdValue=
${get_cad_instances_url}       ${host_url}/customer-account/v1/instance?privateIdValue=

${get_sub_task_url_cpo}   ${host_url}/fbb/disconnect/subscriber/v1/tasks?instanceId=
${get_svd_task_url_cpo}   ${host_url}/fbb/disconnect/service-order/v1/tasks?instanceId=
${get_coa_task_url_cpo}   ${host_url}/fbb/disconnect/order-acceptance/v1/tasks?instanceId=
${get_cad_task_url}       ${host_url}/customer-account/v1/tasks?instanceId=
