*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Test Cases ***
测试GET请求 - 获取用户信息
    # 1. 创建一个会话
    Create Session    my_session    https://jsonplaceholder.typicode.com
    # 2. 发送GET请求
    ${response}=    GET On Session    my_session    /users/1
    # 3. 验证状态码是否为200（成功）
    Status Should Be    200    ${response}
    # 4. 解析并验证返回的JSON数据
    ${json}=    To Json    ${response.content}
    Should Be Equal As Strings    ${json['username']}    Bret
    
    Log    ✅ 测试通过！接口返回的用户名是：${json['username']}