Program BearerTokenAuth;

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
        url: string;
        token: string;
        response: string;

Begin
        { Get your token from the API }
        token := 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';

        client := TFPHTTPClient.Create(nil);
        Try
                { Add the bearer token in the Authorization header }
                client.AddHeader('Authorization', 'Bearer ' + token);
                client.AddHeader('Content-Type', 'application/json');

                Try
                        { Make the request - using a real free API for testing }
                        url := 'https://jsonplaceholder.typicode.com/users/1';
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
