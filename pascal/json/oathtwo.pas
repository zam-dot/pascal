Program OAuth2Example;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes,
        SysUtils,
        opensslsockets,
        fphttpclient,
        fpjson,
        jsonparser;

Var
        client: TFPHTTPClient;
        requestBody: TJSONObject;
        requestString: string;
        responseData: TJSONObject;
        accessToken: string;
        response: TStringStream;
        response2: TStringStream;
        requestBodyStream: TRawByteStringStream;

Begin
        { OAuth 2.0 has several steps, here's a simplified example }

        { Step 1: Get an access token (after user authorization) }
        client := TFPHTTPClient.Create(nil);
        requestBody := TJSONObject.Create;
        responseData := nil;
        response := TStringStream.Create('');
        response2 := TStringStream.Create('');
        requestBodyStream := nil;

        Try
                Try
                        { Create the request for getting a token }
                        requestBody.Strings['grant_type'] := 'authorization_code';
                        requestBody.Strings['code'] := 'authorization-code-from-user';
                        requestBody.Strings['client_id'] := 'your-client-id';
                        requestBody.Strings['client_secret'] := 'your-client-secret';
                        requestBody.Strings['redirect_uri'] := 'http://localhost:8080/callback';

                        requestString := requestBody.AsJSON;

                        client.AddHeader('Content-Type', 'application/json');

                        { Get the token - use Post() with RequestBody }
                        requestBodyStream := TRawByteStringStream.Create(requestString);
                        client.RequestBody := requestBodyStream;
                        client.Post('https://oauth.example.com/token', response);

                        responseData := TJSONObject(GetJSON(response.DataString));
                        accessToken := responseData.Strings['access_token'];

                        WriteLn('Got access token: ', accessToken);

                        { Step 2: Use the access token to access protected resources }
                        client.AddHeader('Authorization', 'Bearer ' + accessToken);

                        client.Get('https://jsonplaceholder.typicode.com/users/1', response2);
                        WriteLn('User info: ', response2.DataString);

                Except
                        on E: Exception Do
                                WriteLn('Error: ', E.Message);
                End;

        Finally
                If Assigned(requestBodyStream) Then
                        requestBodyStream.Free;
                If Assigned(responseData) Then
                        responseData.Free;
                response2.Free;
                response.Free;
                requestBody.Free;
                client.Free;
        End;

        WriteLn('');
        WriteLn('Press enter to exit...');
        ReadLn;
End.
