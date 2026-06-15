Program BasicAuth;

{$mode objfpc}{$H+}{$J-}

Uses
        Classes,
        SysUtils,
        opensslsockets,
        fphttpclient,
        Base64;

Var
        client: TFPHTTPClient;
        url: string;
        username, password: string;
        credentials: string;
        response: string;

Begin
        username := 'your_username';
        password := 'your_password';

        client := TFPHTTPClient.Create(nil);
        Try
                { Combine username and password }
                credentials := username + ':' + password;

                { Encode as base64 }
                credentials := EncodeStringBase64(credentials);

                { Add authorization header }
                client.AddHeader('Authorization', 'Basic ' + credentials);

                Try
                        { Make the request - using a real free API for testing }
                        url := 'https://jsonplaceholder.typicode.com/posts/1';
                        response := client.SimpleGet(url);

                        WriteLn('Response: ', response);

                Except
                        on E: Exception Do
                                WriteLn('Error: ', E.Message);
                End;

        Finally
                client.Free;
        End;

        WriteLn('');
        WriteLn('Press enter to exit...');
        ReadLn;
End.
