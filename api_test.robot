*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    MyLibrary.py

*** Test Cases ***
测试GET请求 - 获取用户信息
    # 1. 创建一个会话
    Create Session    my_session    https://jsonplaceholder.typicode.com
    # 2. 发送GET请求
    ${response}=    GET On Session    my_session    /users/1
    # 3. 验证状态码是否为200（成功）
    Status Should Be    200    ${response}
    # 4. 解析并验证返回的JSON数据
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json['username']}    Bret
    
    Log    ✅ 测试通过！接口返回的用户名是：${json['username']}

测试自定义Python库
    # 1. 调用Python的 get_timestamp 函数
    ${ts}=    get_timestamp
    Log    当前时间戳是：${ts}

    # 2. 调用Python的 add_numbers 函数
    ${sum}=    add_numbers    100    233
    Log    100 + 233 的结果是：${sum}

    # 3. 结合之前的接口测试，检查响应里有没有 'id' 字段
    Create Session    my_session    https://jsonplaceholder.typicode.com
    ${response}=    GET On Session    my_session    /users/1
    ${json}=    Set Variable    ${response.json()}
    ${has_id}=    check_response_contains    ${json}    id
    Log    响应中是否包含 id 字段：${has_id}
    Should Be True    ${has_id}