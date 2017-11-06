<html>
<body>
    <h2>입력 화면</h2>
    <form:form modelAttribute="echoForm">
        <div>텍스트를 입력해 주세요:</div>
        <div>
            <form:input path="text" />
            <form:errors path="text" />
        </div>
        <div>
            <form:button>전송</form:button>
        </div>
    </form:form>
</body>
</html>