*** Settings ***
Library          Selenium2Library
Library          ExcelLibrary
#Library          ExcelRobot
Library          BuiltIn
Library          RequestsLibrary
Library          String
Library          Collections
Library          OperatingSystem
Library          json
Library          JSONLibrary
Library          DateTime
Library          DatabaseLibrary
Library          OperatingSystem
Library          Collections
Library          XML
#Library          RPA.Excel.Application
Resource         Repository/Database/query.robot
Resource         Repository/API/uri.robot
Library          OperatingSystem
Library          pythonFile/decode.py
Library          pythonFile/addMoreCode.py

#Resource        ../../ResourcesNew/Variables/BTA_common_variable.robot

*** Variables ***
${browser}    chrome
${url}    https://google.com/
${expected_result}     Podcasts ไทย

*** Keywords ***
Write Data To Excel
    [Arguments]    ${sheetName}  ${fileName}
    Open Excel Document      ${fileName}    doc1
    ${pathReport}   Set Variable    ${OUTPUT_DIR}${/}report.html
    Log    ${pathReport}

Replace The Variables In Request Body New Register
    ${json}     Get file          Variables/Newregister_1st.json
    ${json}     Replace String    ${json}    {{thaiID}}                         ${thaiID}
    ${json}     Replace String    ${json}    {{privateIdValueKK}}               ${privateIdValueKK}
    ${json}     Replace String    ${json}    {{currentOrderdate}}               ${currentOrderdate}
    ${json}     Replace String    ${json}    {{randomFirstName}}               ${randomFirstName}
    ${json}     Replace String    ${json}    {{randomLastName}}               ${randomLastName}

    Set Global Variable    ${json}
    Log    ${json}


Replace The Variables In Request Body NEW ACCOUNT SFF
    ${xml_req}=    Get File    Variables/NewAccount_SFF.xml
    ${xml_req}     Replace String    ${xml_req}    {{accountType}}                          BA
    ${xml_req}     Replace String    ${xml_req}    {{saNumber}}                             ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{accountCat}}                           R
    ${xml_req}     Replace String    ${xml_req}    {{accountSubCat}}                         THA
    ${xml_req}     Replace String    ${xml_req}    {{idCardType}}                         ID_CARD
    ${xml_req}     Replace String    ${xml_req}    {{idCardNo}}                             ${thaiID}
    ${xml_req}     Replace String    ${xml_req}    {{title}}                            นาย
    ${xml_req}     Replace String    ${xml_req}    {{firstName}}                         ${randomFirstName}
    ${xml_req}     Replace String    ${xml_req}    {{lastName}}                         ${randomLastName}
    ${xml_req}     Replace String    ${xml_req}    {{saleRepName}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{emailAddress}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{homeNo}}                               77/90
    ${xml_req}     Replace String    ${xml_req}    {{buildingName}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{floor}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{room}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{moo}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{mooBan}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{soi}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{street}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{tumbol}}                         จอมทอง
    ${xml_req}     Replace String    ${xml_req}    {{amphur}}                         จอมทอง
    ${xml_req}     Replace String    ${xml_req}    {{province}}                         กรุงเทพ
    ${xml_req}     Replace String    ${xml_req}    {{zipCode}}                         10150
    ${xml_req}     Replace String    ${xml_req}    {{userName}}                         MC
    ${xml_req}     Replace String    ${xml_req}    {{channel}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{mainMobileNo}}                         0987774456
    ${xml_req}     Replace String    ${xml_req}    {{invoicingCompany}}                         AWN
    ${xml_req}     Replace String    ${xml_req}    {{overrideProfileFlag}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{accountName}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{taxPaperFlag}}                         ${Empty}
    ${xml_req}     Replace String    ${xml_req}    {{accntSource}}                         ${Empty}


    Set Global Variable    ${xml_req}
    Log    ${xml_req}

Replace The Variables In Request Body Migrate3BB
    ${json}     Get file          Variables/Migrate3BB.json
    ${json}     Replace String    ${json}    {{privateIdValueKK}}               ${privateIdValueKK}
    ${json}     Replace String    ${json}    {{currentOrderdate}}               ${currentOrderdate}
    ${json}     Replace String    ${json}    {{dayplusOrderdate}}               ${dayplusOrderdate}
    ${json}     Replace String    ${json}    {{dayplusOrderdate2}}              ${dayplusOrderdate2}
    ${json}     Replace String    ${json}    {{mobileNo_Migrate3BB}}            ${mobileNo_Migrate3BB}
    ${json}     Replace String    ${json}    {{baNumberFBB1ST}}                 ${orderRes_Newregister_1st["baNumber"]}
    ${json}     Replace String    ${json}    {{dayplusOrderdate2plusmin10}}     ${dayplusOrderdate2plusmin10}


    Set Global Variable    ${json}
    Log    ${json}

Connect Database on Sky IOT
    Connect To Database Using Custom Params     cx_Oracle     'skyfbbsa/fbb#sa22@10.252.53.34:1533/phxiotdb'

Connect Database on SFF PVT
    Connect To Database Using Custom Params     cx_Oracle     'supanutm/supanutm@172.16.249.36:1536/SFFPVTDB'

Query Database on Sky for check COMPLETE FBB newregister 1st
    [Arguments]     ${ordernoDB}
    Connect Database on Sky IOT
    ${Sky_query_task_orderRefId}            Set Variable    SELECT STATE FROM FBBNEWCDDADM.FBBNEWCDD_INSTANCE fi WHERE id = '${ordernoDB}'
    ${Result0fQuery}=        Query          ${Sky_query_task_orderRefId}
    IF    "${Result0fQuery}[0][0]" == "Completed"
        ${STATE}     set variable         ${True}
    ELSE
        ${STATE}     set variable         ${False}
    END
    Disconnect from database
    RETURN        ${STATE}


Query Database on Sky for check if RESEND FBB newregister 1st
    [Arguments]     ${ordernoDB}
    Connect Database on Sky IOT
    ${Sky_query_task_orderRefId}            Set Variable    SELECT STATE FROM FBBNEWCDDADM.FBBNEWCDD_INSTANCE fi WHERE id = '${ordernoDB}'
    ${Result0fQuery}=        Query          ${Sky_query_task_orderRefId}
    ${loopCheckSTATE}=    Set Variable    ${True}
    ${countQuery}=    Set Variable    0
    WHILE    ${loopCheckSTATE}
         Sleep    4s
         ${Result0fQuery}=        Query          ${Sky_query_task_orderRefId}
         IF    "${Result0fQuery}[0][0]" == "InProgress"
            ${Result0fQuery}=        Query          ${Sky_query_task_orderRefId}
            ${countQuery}=    Evaluate    ${countQuery} + 1
         ELSE IF    ${loopCheckSTATE} == 10
            ${loopCheckSTATE}=    Set Variable    ${False}
         ELSE
            ${loopCheckSTATE}=    Set Variable    ${False}
        END
    END
    IF    "${Result0fQuery}[0][0]" == "Failed"
        ${STATE}     set variable         ${True}
    ELSE
        ${STATE}     set variable         ${False}
    END
    Disconnect from database
    RETURN        ${STATE}


Query Database on SFF for GET mobileno Migrate3BB
    Connect Database on SFF PVT
    ${SFF_query_task_MOBILENO}            Set Variable        SELECT '888' || sffadm.get_seq_no('SFF_SEQ_TBB') from dual
    ${Result0fQuery}=        Query          ${SFF_query_task_MOBILENO}
    log     ${Result0fQuery}[0][0]
    Disconnect from database
    Set Global Variable     ${mobileNo_Migrate3BB}      ${Result0fQuery}[0][0]



Request to Get Token
    [Arguments]    ${params}
    ${header}=      Create Dictionary      Content-Type=application/json;charset=utf-8
    Create Session    tmd    ${host_url}       verify=False     headers=${header}
    ${resp}=    POST On Session   tmd   ${get_token_url}    data=${params}
    Return From Keyword    ${resp}
    Log To Console  ${resp}

API RESEND FBB newregister 1st
    [Arguments]     ${ordernoRESEND}
    ${resp}=        Request to Get Token        ${get_token_body}
    ${resDict}=      Evaluate     json.loads("""${resp.content}""")    json
    ${url}=     set variable         https://test-sky.intra.ais:2443/fbb/register/conductor/v1/order/${ordernoRESEND}
    ${header}=      Create Dictionary      Content-Type=application/json;charset=utf-8              Authorization=${resDict["token"]}
    Create Session    tmd    ${url}       verify=False     headers=${header}
    ${resp}=         PUT On Session        tmd     ${Empty}           expected_status=any


API FBB newregister 1st
    ${resp}=        Request to Get Token        ${get_token_body}
    Log  response=${resp.content}
    ${resDict}=      Evaluate     json.loads("""${resp.content}""")    json
    Log    ${resDict}
    ${orderResp}=       REQUEST FBB newregister 1st       ${resDict["token"]}
    log    ${orderResp}
    ${resp_body}=   Evaluate  json.loads("""${orderResp.content}""")  json
    ${resp_body_dm}=    Json.Dumps      ${resp_body}
    Set Global Variable     ${result_resp}      ${resp_body_dm}
    Set Global Variable     ${orderRes_Newregister_1st}      ${resp_body}
    Log     ${resp_body_dm}
    RETURN        ${resp_body}

REQUEST FBB newregister 1st
    [Arguments]     ${token}
    ${url}=     set variable         https://test-sky.intra.ais:2443/fbb/register/conductor/v1/order
    ${header}=      Create Dictionary      Content-Type=application/json;charset=utf-8              Authorization=${token}
    Create Session    tmd    ${url}       verify=False     headers=${header}
    log     ${json}
    ${object}=  Evaluate  json.loads('''${json}''')  json
    ${jsondm}=      Json.Dumps      ${object}
    Log    ${jsondm}
    ${resp}=         post on session        tmd     ${Empty}       data=${jsondm}       expected_status=any

    Set Global Variable     ${status}       ${resp.status_code}
    RETURN        ${resp}


CALL Newregister 1st fbb
    GENERATE REQUEST ALL VALUE
    Replace The Variables In Request Body New Register
    ${order}=     API FBB newregister 1st
    ${loopRESEND}=      Set Variable    ${True}
    WHILE    ${loopRESEND}
            ${checkCOMPLETE}=      Query Database on Sky for check COMPLETE FBB newregister 1st       ${order["orderNo"]}
            IF    ${checkCOMPLETE}
                ${loopRESEND}=      Set Variable    ${False}
            ELSE
                 ${checkRESEND}=   Query Database on Sky for check if RESEND FBB newregister 1st      ${order["orderNo"]}
                 RUN KEYWORD IF    ${checkRESEND}    API RESEND FBB newregister 1st      ${order["orderNo"]}
            END
    END

    Log    ${order}


API Migrate3BB
    ${resp}=        Request to Get Token        ${get_token_body}
    Log  response=${resp.content}
    ${resDict}=      Evaluate     json.loads("""${resp.content}""")    json
    Log    ${resDict}
    ${orderResp}=       REQUEST Migrate3BB       ${resDict["token"]}
    log    ${orderResp}
    ${resp_body}=   Evaluate  json.loads("""${orderResp.content}""")  json
    ${resp_body_dm}=    Json.Dumps      ${resp_body}
    Set Global Variable     ${result_resp}      ${resp_body_dm}
    Set Global Variable     ${orderRes_Migrate3BB}      ${resp_body}
    Log     ${resp_body_dm}
    RETURN        ${resp_body}


REQUEST Migrate3BB
    [Arguments]     ${token}
    ${url}=     set variable         https://test-sky.intra.ais:2443/fbb/register/conductor/v1/order
    ${header}=      Create Dictionary      Content-Type=application/json;charset=utf-8              Authorization=${token}
    Create Session    tmd    ${url}       verify=False     headers=${header}
    log     ${json}
    ${object}=  Evaluate  json.loads('''${json}''')  json
    ${jsondm}=      Json.Dumps      ${object}
    Log    ${jsondm}
    ${resp}=         post on session        tmd     ${Empty}       data=${jsondm}       expected_status=any

    Set Global Variable     ${status}       ${resp.status_code}
    RETURN        ${resp}


CALL Migrate3BB
    GENERATE REQUEST ALL VALUE
    Query Database on SFF for GET mobileno Migrate3BB
    Replace The Variables In Request Body Migrate3BB
    ${order}=     API Migrate3BB

    Log    ${order}

Random ThaiID
    ${thai_id}=      Generate Thai Citizen ID
    Set Global Variable     ${thaiID}       ${thai_id}


GET ALL DATE FORMAT
    ${date}=      Get Current Date    exclude_millis=no
    ${date}     Convert Date      ${date}      result_format=%Y%m%d%H%M%S%f
    ${years}=   Convert Date     ${date}      result_format=%Y
    ${month}=   Convert Date     ${date}      result_format=%m
    ${day}=   Convert Date     ${date}      result_format=%d
    ${day_int}=    Evaluate    '${day}'.lstrip('0') or '0'
    ${dayplus}=   Evaluate    ${day_int} + 1
    ${dayplus}=   Evaluate    '0' + str(${dayplus}) if len(str(${dayplus})) == 1 else str(${dayplus})
    ${dayplus2}=   Evaluate    ${day_int} + 2
    ${dayplus2}=   Evaluate    '0' + str(${dayplus2}) if len(str(${dayplus2})) == 1 else str(${dayplus2})
    ${hours}=  Convert Date    ${date}       result_format=%H
    ${minutes}=  Convert Date    ${date}       result_format=%M
    ${minutesplus10}=  Evaluate    '${minutes}'.lstrip('0') or '0' + 10
    ${minutesplus10}=  Evaluate    '0' + str(${minutesplus10}) if len(str(${minutesplus10})) == 1 else str(${minutesplus10})
    ${seconds}=  Convert Date    ${date}       result_format=%S
    ${millisec}=  Convert Date    ${date}       result_format=%f
    ${millisec}=  Set Variable      ${millisec[:4]}
    ${time}=    Convert Date   ${date}     result_format=%H:%M:%S
    ${timeplusmin10}=    set variable    ${hours}:${minutesplus10}:${seconds}
    ${today}=   set variable    ${day}/${month}/${years} ${time}
    ${dayplusOrderdate}=   set variable    ${dayplus}/${month}/${years} ${time}
    ${dayplusOrderdate2}=   set variable    ${dayplus2}/${month}/${years} ${time}
    ${dayplusOrderdate2plusmin10}=   set variable    ${dayplus2}/${month}/${years} ${timeplusmin10}
    ${privateIdValueKK}=       Set Variable    ${years}-${month}-${day}KK${hours}${minutes}${seconds}${millisec}
    set global variable     ${today}
    set global variable     ${privateIdValueKK}
    set global variable     ${currentOrderdate}     ${today}
    set global variable     ${dayplusOrderdate}
    set global variable     ${dayplusOrderdate2}
    set global variable     ${dayplusOrderdate2plusmin10}



Random Name
    ${jsonName}     Get file          dataJson/allName.json
    ${respallname}=  Evaluate  json.loads('''${jsonName}''')  json
    ${random_numberfirstname}=    Evaluate    random.randint(2, 2)    random
    ${firstnamelist}    Set Variable       ${respallname["firstnameMale"]}
    ${firstnamelist}      set variable      ${respallname["firstnameMale"]}
    ${lastnamelist}      set variable      ${respallname["lastname"]}
    ${randomnumbername}=    Get Length    ${firstnamelist}
    ${randomnumberlast}=    Get Length    ${lastnamelist}
    ${random_namelist}=    Evaluate    random.randint(0, ${randomnumbername} - 1)    random
    ${random_lastlist}=    Evaluate    random.randint(0, ${randomnumberlast} - 1)    random
    Set Global Variable     ${randomFirstName}       ${firstnamelist[${random_namelist}]['th']}
    Set Global Variable     ${randomLastName}       ${lastnamelist[${random_lastlist}]['th']}


GENERATE REQUEST ALL VALUE
    Random Name
    Random ThaiID
    GET ALL DATE FORMAT


CALL NEW ACCOUNT SFF
    GENERATE REQUEST ALL VALUE
    Replace The Variables In Request Body NEW ACCOUNT SFF
    ${order}=     API NEW ACCOUNT SFF

    Log    ${order}


REQUEST NEW ACCOUNT SFF
    [Arguments]     ${token}
    ${url}=     set variable         http://10.252.64.153:8803/SFFWebService/SFFService
    ${header}=      Create Dictionary      Content-Type=text/xml;charset=utf-8              Authorization=${token}
    Create Session    tmd    ${url}       verify=False     headers=${header}

    ${resp}=         post on session        tmd     ${Empty}       data=${xml_req}       expected_status=any

    Set Global Variable     ${status}       ${resp.status_code}
    RETURN        ${resp}



API NEW ACCOUNT SFF
    ${resp}=        Request to Get Token        ${get_token_body}
    Log  response=${resp.content}
    ${resDict}=      Evaluate     json.loads("""${resp.content}""")    json
    Log    ${resDict}
    ${orderResp}=       REQUEST NEW ACCOUNT SFF       ${resDict["token"]}
    log    ${orderResp.content}
    Set Global Variable     ${orderRes_account_sff}      ${orderResp.content}
    RETURN        ${orderResp.content}



*** Test Cases ***

Test Newregister 1st fbb > Migrate3bb
    CALL Newregister 1st fbb
    CALL Migrate3BB
    Log    ${orderRes_Newregister_1st}
    Log    ${orderRes_Migrate3BB}


Test query
    ${tes}=   Query Database on Sky for check if RESEND FBB newregister 1st      FS-lqxzx-240827104739552318620871
    Log    ${tes}

Test Excel
    Write Data To Excel     "KK"      "Newregister"


OPEN MICKY
    Open Browser    https://10.137.20.37:8103/WebTestWorkOrder/portal.jsf    firefox
    Input Text    id=frm:username    bandh443
    Input Text    id=frm:password    bandh443
    Press Keys    class=rich-button    RETURN
    Sleep    20s
    Press Keys    href=create_newaccount_ws.jsf    RETURN


test call sff
    CALL NEW ACCOUNT SFF
    ${xmlaccount}      Parse Xml    ${orderRes_account_sff}
    ${xmlaccount_result}        Get Element    ${xmlaccount}        Body/ExecuteServiceResponse/return/ParameterList
    ${xmlaccount_result_test}       Get Element Text    ${xmlaccount_result}
    ${len_result}           Get Length    ${xmlaccount_result}
    FOR    ${i}    IN RANGE    1    ${len_result}-1
        ${result_name}        Set Variable        ${xmlaccount_result[${i}][0]}
        ${result_value}        Set Variable        ${xmlaccount_result[${i}][1]}
        ${result_name_text}       Get Element Text    ${result_name}
        ${result_value_text}       Get Element Text    ${result_value}
        Log    ${result_name_text}
        Log    ${result_value_text}

    END
    Log    ${xmlaccount_result_test}
