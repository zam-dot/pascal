Program APIKeyAuth;

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
        apiKey: string;
        response: string;

Begin
        { Get your API key from the service }
        apiKey := 'your-api-key-here';

        client := TFPHTTPClient.Create(nil);
        Try
                { Add the API key as a header }
                client.AddHeader('X-API-Key', apiKey);

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
