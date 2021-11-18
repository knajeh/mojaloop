ml-testing-toolkit:
  enabled: ${internal_ttk_enabled}
  ml-testing-toolkit-backend:
    image:
      repository: mojaloop/ml-testing-toolkit
      tag: v14.0.2
    ingress:
      hosts:
        specApi:
          host: ttkbackend.${env}.${name}.${domain}.internal
          port: 5000
          paths: ['/']
        adminApi:
          host: ttkbackend.${env}.${name}.${domain}.internal
          port: 5050
          paths: ['/api/', '/socket.io/']
    config:
      user_config.json: {
        "VERSION": 1,
        "CALLBACK_ENDPOINT": "http://localhost:4000",
        "CALLBACK_RESOURCE_ENDPOINTS": {
          "enabled": true,
          "endpoints": [
            {
              "method": "put",
              "path": "/parties/{Type}/{ID}",
              "endpoint": "http://$release_name-account-lookup-service"
            },
            {
              "method": "put",
              "path": "/quotes/{ID}",
              "endpoint": "http://$release_name-quoting-service"
            },
            {
              "method": "put",
              "path": "/transfers/{ID}",
              "endpoint": "http://$release_name-ml-api-adapter-service"
            }
          ]
        },
        "HUB_ONLY_MODE": false,
        "ENDPOINTS_DFSP_WISE": {
          "dfsps": {
            "userdfsp": {
              "defaultEndpoint": "http://scheme-adapter:4000",
              "endpoints": []
            },
            "userdfsp2": {
              "defaultEndpoint": "http://scheme-adapter2:4000",
              "endpoints": []
            }
          }
        },
        "SEND_CALLBACK_ENABLE": true,
        "FSPID": "testingtoolkitdfsp",
        "DEFAULT_USER_FSPID": "userdfsp",
        "TRANSFERS_VALIDATION_WITH_PREVIOUS_QUOTES": true,
        "TRANSFERS_VALIDATION_ILP_PACKET": true,
        "TRANSFERS_VALIDATION_CONDITION": true,
        "ILP_SECRET": "secret",
        "VERSIONING_SUPPORT_ENABLE": true,
        "VALIDATE_INBOUND_JWS": false,
        "VALIDATE_INBOUND_PUT_PARTIES_JWS": false,
        "JWS_SIGN": false,
        "JWS_SIGN_PUT_PARTIES": false,
        "CLIENT_MUTUAL_TLS_ENABLED": false,
        "ADVANCED_FEATURES_ENABLED": true,
        "CALLBACK_TIMEOUT": 20000,
        "DEFAULT_REQUEST_TIMEOUT": 5000,
        "SCRIPT_TIMEOUT": 5000,
        "LOG_SERVER_UI_URL": "${kibana_url}",
        "UI_CONFIGURATION": {
          "MOBILE_SIMULATOR": {
            "HUB_CONSOLE_ENABLED": true
          }
        },
        "CLIENT_TLS_CREDS": [
          {
            "HOST": "testfsp1",
            "CERT": "-----BEGIN CERTIFICATE-----\nMIIFATCCAumgAwIBAgIUEcEtqgcXBoTykvaD6PprzY8kxpYwDQYJKoZIhvcNAQEL\nBQAwfzERMA8GA1UEChMITW9kdXNCb3gxHDAaBgNVBAsTE0luZnJhc3RydWN0dXJl\nIFRlYW0xTDBKBgNVBAMTQ3Rlc3Rmc3AxLnFhLnByZS5teWFubWFycGF5LXByZS5p\nby5pbnRlcm5hbCB0ZXN0ZnNwMSBJbnRlcm1lZGlhdGUgQ0EwHhcNMjEwMjIyMTkw\nMTEyWhcNMjMwMjIzMDY0MDA2WjBdMREwDwYDVQQKEwhNb2R1c0JveDEcMBoGA1UE\nCxMTSW5mcmFzdHJ1Y3R1cmUgVGVhbTEqMCgGA1UEAxMhdGVzdGZzcDEucWEucHJl\nLm15YW5tYXJwYXktcHJlLmlvMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC\nAQEApndEBbmdlfrpnidagKb2D32bEL+iGYxLEicdQVs24018zNPdbrIYtXyDjgjA\nq718HH5XQW2FSz6cA1CbQ6jLuY88EZRUiCSJ4rCkENWw+mpVLyOd+mcYU4JwOQNC\nP+W8GGcW/haifkXtHEDUO4pIxnXWC6DftvxZ3TH5PxtWO8aJcsoj94oBTPOhnGi0\nC356XyseYl7o7hdxZu3DvY3Wyh/k5pDDHOCjQYxl9wjtW+BVWMCFxRaCu4f/3LVj\nca9BccwZ8O4Rdhu6lhJEUCUgTqdx3vXRB1xzwHT0W7gariy4RVbvwE35AaCliyEr\n4O5WlCvAMOct7POYDAwNuoeb7wIDAQABo4GWMIGTMA4GA1UdDwEB/wQEAwIDqDAT\nBgNVHSUEDDAKBggrBgEFBQcDAjAdBgNVHQ4EFgQU2alVxVOOplYXiLAYCDaII4E0\n/WgwHwYDVR0jBBgwFoAUCFvcCetcirxZPE3N6qMdOo5H7Z4wLAYDVR0RBCUwI4Ih\ndGVzdGZzcDEucWEucHJlLm15YW5tYXJwYXktcHJlLmlvMA0GCSqGSIb3DQEBCwUA\nA4ICAQBkX5LItY0calp7NT21O8z+iufVNV8onEch4J7HJjEVwtCB4UVl7LrWJ3cw\n9KLt7nj85/AUuuhtNPJO9DW/x+0xRyW94Ef5MYHP3nheFWTag8riYl/1SXljOssS\nHCpTvRhirnfGeqBGO1OBwCbkYNIEZI95eMerVoPFm0PfGBb4DJ6mUdfc3qzeOP7K\nOlE5VMhwH2PYv1TS7Hpj1k/1dxpdvyOs7EKVvWD+OokLhJaHgU8NWVetTUtsXSN/\nTv06ZN8JGTN/Udm7POVyEaol8Jw2FRGGKcwOBKbqroNs6POqTofqZeL4SFAkzzQL\nvOAhbQIB6GSznG1Gg1G9IjGVCMXUhpNK2PD8RR1ovzi0MZlRkITGRPhBYQf5xMFl\nZeq0mGFQR3VYDdlwT0O37C8fpaYvpdupeYdxcB623PNz1VkO1MbsXnOoHY8kcFGa\nMh4IARCeR/MwXNWHpGrd6J5Mzmhk0Vy8GyBbqcROUpNR/XTZYRTyfTEq5+amJyLi\n67OB9FP5cS7oQhj7gsaQCTJlxbh/CjmQdKmIimWSEZkDePK5eExNPafBk47tx4KA\nFmh9pIqRyheROesa/zTDGYySNcVd14dl703pyZQNO4b5rap0SZoyGDTfI+7OqAHM\nAz0kWYyZps2nqPZgbwDFigIy2TESvoXahCCtNUoCy9sawa3Diw==\n-----END CERTIFICATE-----",
            "KEY": "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEApndEBbmdlfrpnidagKb2D32bEL+iGYxLEicdQVs24018zNPd\nbrIYtXyDjgjAq718HH5XQW2FSz6cA1CbQ6jLuY88EZRUiCSJ4rCkENWw+mpVLyOd\n+mcYU4JwOQNCP+W8GGcW/haifkXtHEDUO4pIxnXWC6DftvxZ3TH5PxtWO8aJcsoj\n94oBTPOhnGi0C356XyseYl7o7hdxZu3DvY3Wyh/k5pDDHOCjQYxl9wjtW+BVWMCF\nxRaCu4f/3LVjca9BccwZ8O4Rdhu6lhJEUCUgTqdx3vXRB1xzwHT0W7gariy4RVbv\nwE35AaCliyEr4O5WlCvAMOct7POYDAwNuoeb7wIDAQABAoIBAB4YIawHSn36xpFY\n+/uWM5XJV2dHvb5wpoG5oIhYPSwKri05gCaq+9yTjhT3cB2cO/vKu2uQqTBZOUtA\nH1G0CmCZjHqBHmcec+8PkBmbCEu9PXkwLzc9vCAczL0B4dA7cC3ZNUbqQKYjbiJV\ndgjtjwqR8whXJRqntHdQuYa3InfbufcHNHhSXJwE9MqVRpsv/BfY9wjhQfGBHUnT\nCz41xj1bu8Uy4+/1sRF/l9fYDm5E6WbgzvI49/fM7hA+8fQqoRkFLlEzzBhWb93Q\n2qVo2Y5RhVpffdyxPYX7b9RI7UmUZYp2sLl5GYj5ZzTzsffwUdPl2pZlRkYJGvUo\nortpToECgYEA17NVIZgeQ5VcSsZKGJlzPkcdPoWCk7RY5DugxTaNwSE/uO25B/Ax\nBPE6ZC9LbfXyfTQXaam2VtpSzvNJ7p7j30qkEK0Z+I2pGAVohZg4enkHaIQkYtIP\naZZ/wce5R8VZq6EpToprTm3cG6T+nNVOzqRjUqgnUZyY8nWy2CD5OucCgYEAxZEb\nOKjo9Iwrod2uOZlQDAsnTvgqZySW/lORrnfEWmOEiJpRvjlxMfNPNlc2iMTBQShq\naPZi48g17btU8ACs2NOH/FXuxooDe+0gJDj48WP9/bBzOAOJqhKZ+g9l/Cr978yJ\nAHNh/w8foUUkqAfxmXoTImw7LdSaPIc7ewAlPbkCgYAcGq6d6O8QiTZ0O6/N0riU\nRbnGuqiPzDDE1AwXhgskPcvKsZapNR998FxWT185nZERxSbDyqwKVvnxIvvgDm3M\nWzJTReqbWwHMMnAy7+lz868GbCk9gvclH8nXmslGU61iUmZKaHigyGmkZHQURSq2\ne+7BB03QMWIwPSunQ2yVwwKBgQCbPrzvNvtnPsYCeZmwNSLLc/A9g5B+YCguTSjK\nud4XUOASH4FgQu8J2zFBeCKoMkPRmZqURBfM+cQ2vN+vgDhSYVYYGMZ6SHUYamq5\nS/OCa5poQMEpIM6KT/eioXr4PigwyL5XFlPJAu9N4HE/gI5+lYh3oiiWiNtx+Knq\nq2CYMQKBgQCv+QTGDrSc3SUaWT+JMoFdfzvJyyqQOUvgRbSGAp5GryYqI9dozx70\nlT2IdoAZ0DHrJhNs13Pr7ngXwqS6pKlZU8NSX2ch7h5ZwIsYJESzKwXF/frLMQSy\nTPV3d0hb7UaW3wqOx2Dbj8vJJdvUo3UUkOcmgesqGg3nf3t51I6k0A==\n-----END RSA PRIVATE KEY-----"
          }
        ],
        "GITHUB_CONFIG": {
          "TEST_CASES_REPO_OWNER": "mojaloop",
          "TEST_CASES_REPO_NAME": "testing-toolkit-test-cases",
          "TEST_CASES_REPO_DEFAULT_RELEASE_TAG": "latest",
          "TEST_CASES_REPO_BASE_PATH": "collections/hub",
          "TEST_CASES_REPO_HUB_GP_PATH": "collections/hub/golden_path",
          "TEST_CASES_REPO_HUB_PROVISIONING_PATH": "collections/hub/provisioning"
        },
        "DEFAULT_ENVIRONMENT_FILE_NAME": "hub-k8s-default-environment.json",
        "LABELS": [
          {
            "name": "p2p",
            "description": "Tests related to p2p transfer",
            "color": "red"
          },
          {
            "name": "settlements",
            "description": "Tests related to settlements",
            "color": "green"
          },
          {
            "name": "quotes",
            "description": "Tests related to quoting service",
            "color": "blue"
          }
        ]
      }
      system_config.json: {
        "API_PORT": 5000,
        "HOSTING_ENABLED": false,
        "INBOUND_MUTUAL_TLS_ENABLED": false,
        "OUTBOUND_MUTUAL_TLS_ENABLED": false,
        "CONFIG_VERSIONS": {
          "response": 1,
          "callback": 1,
          "validation": 1,
          "forward": 1,
          "userSettings": 1
        },
        "DB": {
          "URI": "mongodb://ttk:ttk@$mongodb_host:$mongodb_port/ttk"
        },
        "OAUTH": {
          "AUTH_ENABLED": false,
          "APP_OAUTH_CLIENT_KEY": "ttk",
          "APP_OAUTH_CLIENT_SECRET": "23b898a5-63d2-4055-bbe1-54efcda37e7d",
          "MTA_ROLE": "Application/MTA",
          "PTA_ROLE": "Application/PTA",
          "EVERYONE_ROLE": "Internal/everyone",
          "OAUTH2_TOKEN_ISS": "http://$auth_host:$auth_port$auth_token_iss_path",
          "OAUTH2_ISSUER": "http://$auth_host:$auth_port$auth_issuer_path",
          "EMBEDDED_CERTIFICATE": "$auth_embedded_certificate"
        },
        "KEYCLOAK": {
          "ENABLED": false,
          "API_URL": "http://$auth_host:$auth_port",
          "REALM": "testingtoolkit",
          "ADMIN_REALM": "master",
          "ADMIN_USERNAME": "admin",
          "ADMIN_PASSWORD": "admin",
          "ADMIN_CLIENT_ID": "admin-cli"
        },
        "SERVER_LOGS": {
          "ENABLED": true,
          "RESULTS_PAGE_SIZE": 50,
          "ADAPTER": {
            "TYPE": "ELASTICSEARCH",
            "INDEX": "mojaloop*",
            "API_URL": "${elasticsearch_url}"
          }
        },
        "CONNECTION_MANAGER": {
          "ENABLED": false,
          "API_URL": "http://$connection_manager_host:$connection_manager_port",
          "AUTH_ENABLED": false,
          "HUB_USERNAME": "hub",
          "HUB_PASSWORD": "hub"
        },
        "HTTP_CLIENT": {
          "KEEP_ALIVE": false,
          "MAX_SOCKETS": 50,
          "UNUSED_AGENTS_EXPIRY_MS": 1800000,
          "UNUSED_AGENTS_CHECK_TIMER_MS": 300000
        },    
        "API_DEFINITIONS": [
          {
            "type": "fspiop",
            "version": "1.0",
            "folderPath": "fspiop_1.0",
            "asynchronous": true
          },
          {
            "type": "fspiop",
            "version": "1.1",
            "folderPath": "fspiop_1.1",
            "asynchronous": true
          },
          {
            "type": "settlements",
            "version": "1.0",
            "folderPath": "settlements_1.0"
          },
          {
            "type": "settlements",
            "version": "2.0",
            "folderPath": "settlements_2.0"
          },
          {
            "type": "central_admin",
            "caption": "(old)",
            "version": "9.3",
            "folderPath": "central_admin_old_9.3"
          },
          {
            "type": "central_admin",
            "version": "1.0",
            "folderPath": "central_admin_1.0"
          },
          {
            "type": "als_admin",
            "version": "1.1",
            "folderPath": "als_admin_1.1"
          },
          {
            "type": "mojaloop_simulator",
            "version": "0.1",
            "folderPath": "mojaloop_simulator_0.1"
          },
          {
            "type": "mojaloop_sdk_outbound_scheme_adapter",
            "version": "1.0",
            "folderPath": "mojaloop_sdk_outbound_scheme_adapter_1.0"
          },
          {
            "type": "payment_manager",
            "version": "1.4",
            "folderPath": "payment_manager_1.4"
          },
          {
            "type": "thirdparty_sdk_outbound",
            "version": "0.1",
            "folderPath": "thirdparty_sdk_outbound_0.1"
          }
        ]
      }

    extraEnvironments:
      hub-k8s-cgs-environment.json: null
      hub-k8s-default-environment.json: &ttkInputValues {
        "inputValues": {
          "BASE_CENTRAL_LEDGER_ADMIN": "",
          "CALLBACK_ENDPOINT_BASE_URL": "http://$release_name-ml-testing-toolkit-backend:5000",
          "ENABLE_JWS_SIGNING": true,
          "ENABLE_JWS_VALIDATION": false,
          "ENABLE_PROTECTED_HEADERS_VALIDATION": true,
          "ENABLE_WS_ASSERTIONS": true,
          "HOST_ACCOUNT_LOOKUP_ADMIN": "http://$release_name-account-lookup-service-admin",
          "HOST_ACCOUNT_LOOKUP_SERVICE": "http://$release_name-account-lookup-service",
          "HOST_ACCOUNT_LOOKUP_SERVICE_ADMIN": "http://$release_name-account-lookup-service-admin",
          "HOST_BULK_ADAPTER": "http://$release_name-bulk-api-adapter-service",
          "HOST_CENTRAL_LEDGER": "http://$release_name-centralledger-service",
          "HOST_CENTRAL_SETTLEMENT": "http://$release_name-centralsettlement-service/v2",
          "HOST_LEGACY_SIMULATOR": "http://$release_name-simulator",
          "HOST_ML_API_ADAPTER": "http://$release_name-ml-api-adapter-service",
          "HOST_QUOTING_SERVICE": "http://$release_name-quoting-service",
          "HOST_SIMULATOR": "http://$release_name-simulator",
          "HOST_TRANSACTION_REQUESTS_SERVICE": "http://$release_name-transaction-requests-service",
          "HUB_OPERATOR_BEARER_TOKEN": "NOT_APPLICABLE",
          "PAYEEFSP_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}payeefsp-backend:3003",
          "PAYEEFSP_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}payeefsp-scheme-adapter:4000",
          "PAYEEFSP_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}payeefsp-scheme-adapter:4002",
          "PAYEEFSP_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}payeefsp-scheme-adapter:4002",
          "PAYERFSP_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}payerfsp-backend:3003",
          "PAYERFSP_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}payerfsp-scheme-adapter:4000",
          "PAYERFSP_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}payerfsp-scheme-adapter:4002",
          "PAYERFSP_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}payerfsp-scheme-adapter:4002",
          "SIMPAYEE_CURRENCY": "USD",
          "SIMPAYEE_JWS_PUB_KEY": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzLtduponsAlAk+3+PQdE\nsgjxRs5qhkrPa0z25NbHvgQYan4bH5GY+nEUX65YN65nusHtCG9gBeU0C56EgZQw\nIpkHDTh166qQGPwdJf5oMlMJn79DSd1I2bghbsNx0a1P6ElH16AyEwvgYtdtMOBW\nNgf7z5/tYgv7bGgmsp3qGlf0nnaux/frJhJ0Hxpd6eUCafwdlrNwc9R6iCKMSxGj\nvVTHgx0D7zSZ/+4PXq6gObyIZoC0uOsKKzlY3USx9khAh+96qfFoNKyfGHltpEPJ\nLmOLh3BtzDuna2KwtNdVNGcjPdCle3b9mNIdhR5aZ/bP6Zm+t9JuRC6ZwU/6WEy3\nFwIDAQAB\n-----END PUBLIC KEY-----\n",
          "SIMPAYEE_MSISDN": "17039811902",
          "SIMPAYEE_NAME": "${internal_sim_prefix}payeefsp",
          "SIMPAYER_CURRENCY": "USD",
          "SIMPAYER_MSISDN": "17039811901",
          "SIMPAYER_NAME": "${internal_sim_prefix}payerfsp",
          "TESTFSP1_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp1-backend:3003",
          "TESTFSP1_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp1-scheme-adapter:4000",
          "TESTFSP1_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp1-scheme-adapter:4002",
          "TESTFSP1_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}testfsp1-scheme-adapter:4002",
          "TESTFSP2_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp2-backend:3003",
          "TESTFSP2_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp2-scheme-adapter:4000",
          "TESTFSP2_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp2-scheme-adapter:4002",
          "TESTFSP2_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}testfsp2-scheme-adapter:4002",
          "TESTFSP3_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp3-backend:3003",
          "TESTFSP3_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp3-scheme-adapter:4000",
          "TESTFSP3_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp3-scheme-adapter:4002",
          "TESTFSP3_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}testfsp3-scheme-adapter:4002",
          "TESTFSP4_BACKEND_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp4-backend:3003",
          "TESTFSP4_CALLBACK_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp4-scheme-adapter:4000",
          "TESTFSP4_SDK_TESTAPI_URL": "http://$release_name-sim-${internal_sim_prefix}testfsp4-scheme-adapter:4002",
          "TESTFSP4_SDK_TESTAPI_WS_URL": "ws://$release_name-sim-${internal_sim_prefix}testfsp4-scheme-adapter:4002",
          "TEST_NOTIFICATIONS": true,
          "TTKFSP_JWS_KEY": "-----BEGIN PRIVATE KEY-----\n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\nDktFAP1w3ruycnE/t+/H8rDVJGPTHc8=\n-----END PRIVATE KEY-----\n",
          "WS_ASSERTION_TIMEOUT": 5000,
          "accept": "application/vnd.interoperability.parties+json;version=1.0",
          "acceptParticipants": "application/vnd.interoperability.participants+json;version=1.0",
          "acceptQuotes": "application/vnd.interoperability.quotes+json;version=1.0",
          "acceptTransfers": "application/vnd.interoperability.transfers+json;version=1.0",
          "accountId": "6",
          "amount": "100",
          "batchToIdValue1": "27713803066",
          "batchToIdValue2": "27713803067",
          "condition": "n2cwS3w4ekGlvNYoXg2uBAqssu3FCoXjADE2mziU5jU",
          "contentTransfers": "application/vnd.interoperability.transfers+json;version=1.0",
          "contentType": "application/vnd.interoperability.parties+json;version=1.0",
          "contentTypeParticipants": "application/vnd.interoperability.participants+json;version=1.0",
          "contentTypeQuotes": "application/vnd.interoperability.quotes+json;version=1.0",
          "currency": "USD",
          "currency2": "TZS",
          "fromDOB": "1984-01-01",
          "fromFirstName": "Firstname-Test",
          "fromFspId": "testingtoolkitdfsp",
          "fromIdType": "MSISDN",
          "fromIdValue": "44123456789",
          "fromLastName": "Lastname-Test",
          "fspiopSignature": "{\"signature\":\"iU4GBXSfY8twZMj1zXX1CTe3LDO8Zvgui53icrriBxCUF_wltQmnjgWLWI4ZUEueVeOeTbDPBZazpBWYvBYpl5WJSUoXi14nVlangcsmu2vYkQUPmHtjOW-yb2ng6_aPfwd7oHLWrWzcsjTF-S4dW7GZRPHEbY_qCOhEwmmMOnE1FWF1OLvP0dM0r4y7FlnrZNhmuVIFhk_pMbEC44rtQmMFv4pm4EVGqmIm3eyXz0GkX8q_O1kGBoyIeV_P6RRcZ0nL6YUVMhPFSLJo6CIhL2zPm54Qdl2nVzDFWn_shVyV0Cl5vpcMJxJ--O_Zcbmpv6lxqDdygTC782Ob3CNMvg\\\",\\\"protectedHeader\\\":\\\"eyJhbGciOiJSUzI1NiIsIkZTUElPUC1VUkkiOiIvdHJhbnNmZXJzIiwiRlNQSU9QLUhUVFAtTWV0aG9kIjoiUE9TVCIsIkZTUElPUC1Tb3VyY2UiOiJPTUwiLCJGU1BJT1AtRGVzdGluYXRpb24iOiJNVE5Nb2JpbGVNb25leSIsIkRhdGUiOiIifQ\"}",
          "homeTransactionId": "123ABC",
          "hubEmail": "some.email@gmail.com",
          "hub_operator": "NOT_APPLICABLE",
          "ilpPacket": "AYIDBQAAAAAAACcQJGcucGF5ZWVmc3AubXNpc2RuLnt7cmVjZWl2ZXJtc2lzZG59fYIC1GV5SjBjbUZ1YzJGamRHbHZia2xrSWpvaVptVXhNREU0Wm1NdE1EaGxZeTAwWWpJM0xUbGpZalF0TnpjMk9URTFNR00zT1dKaklpd2ljWFZ2ZEdWSlpDSTZJbVpsTVRBeE9HWmpMVEE0WldNdE5HSXlOeTA1WTJJMExUYzNOamt4TlRCak56bGlZeUlzSW5CaGVXVmxJanA3SW5CaGNuUjVTV1JKYm1adklqcDdJbkJoY25SNVNXUlVlWEJsSWpvaVRWTkpVMFJPSWl3aWNHRnlkSGxKWkdWdWRHbG1hV1Z5SWpvaWUzdHlaV05sYVhabGNrMVRTVk5FVG4xOUlpd2labk53U1dRaU9pSndZWGxsWldaemNDSjlmU3dpY0dGNVpYSWlPbnNpY0dGeWRIbEpaRWx1Wm04aU9uc2ljR0Z5ZEhsSlpGUjVjR1VpT2lKTlUwbFRSRTRpTENKd1lYSjBlVWxrWlc1MGFXWnBaWElpT2lJeU56Y3hNemd3TXprd05TSXNJbVp6Y0Vsa0lqb2ljR0Y1WlhKbWMzQWlmU3dpY0dWeWMyOXVZV3hKYm1adklqcDdJbU52YlhCc1pYaE9ZVzFsSWpwN0ltWnBjbk4wVG1GdFpTSTZJazFoZEhNaUxDSnNZWE4wVG1GdFpTSTZJa2hoWjIxaGJpSjlMQ0prWVhSbFQyWkNhWEowYUNJNklqRTVPRE10TVRBdE1qVWlmWDBzSW1GdGIzVnVkQ0k2ZXlKaGJXOTFiblFpT2lJeE1EQWlMQ0pqZFhKeVpXNWplU0k2SWxWVFJDSjlMQ0owY21GdWMyRmpkR2x2YmxSNWNHVWlPbnNpYzJObGJtRnlhVzhpT2lKVVVrRk9VMFpGVWlJc0ltbHVhWFJwWVhSdmNpSTZJbEJCV1VWU0lpd2lhVzVwZEdsaGRHOXlWSGx3WlNJNklrTlBUbE5WVFVWU0luMTkA",
          "invalidFulfillment": "_3cco-YN5OGpRKVWV3n6x6uNpBTH9tYUdOYmHA-----",
          "invalidToIdType": "ACCOUNT_ID",
          "invalidToIdValue": "27713803099",
          "note": "test",
          "payeeIdType": "MSISDN",
          "payeeIdentifier": "17039811902",
          "payeefsp": "${internal_sim_prefix}payeefsp",
          "payeefspEmail": "some.email@gmail.com",
          "payerIdType": "MSISDN",
          "payerIdentifier": "17039811901",
          "payerfsp": "testingtoolkitdfsp",
          "payerfspEmail": "some.email@gmail.com",
          "receiverMSISDN": "27713803912",
          "testfsp1Email": "some.email@gmail.com",
          "testfsp1IdType": "MSISDN",
          "testfsp1Identifier": "17039811903",
          "testfsp1MSISDN": "17039811903",
          "testfsp2Email": "some.email@gmail.com",
          "testfsp2IdType": "MSISDN",
          "testfsp2Identifier": "17039811904",
          "testfsp2MSISDN": "17039811904",
          "toFspId": "${internal_sim_prefix}payeefsp",
          "toIdType": "MSISDN",
          "toIdValue": "27713803912",
          "toIdValueDelete": "27713803913",
          "toAccentIdType": "MSISDN",
          "toAccentIdValue": "97039819999",
          "toAccentIdDOB": "2000-01-01",
          "toAccentIdFirstName": "Seán",
          "toAccentIdMiddleName": "François",
          "toAccentIdLastName": "Nuñez",
          "toAccentIdFspId": "${internal_sim_prefix}payeefsp",
          "toBurmeseIdType": "MSISDN",
          "toBurmeseIdValue": "2224448888",
          "toBurmeseIdDOB": "1990-01-01",
          "toBurmeseIdFirstName": "ကောင်းထက်စံ",
          "toBurmeseIdMiddleName": "အောင်",
          "toBurmeseIdLastName": "ဒေါ်သန္တာထွန်",
          "toBurmeseIdFspId": "${internal_sim_prefix}payeefsp",
          "validCondition": "GRzLaTP7DJ9t4P-a_BA0WA9wzzlsugf00-Tn6kESAfM",
          "validCondition2": "kPLCKM62VY2jbekuw3apCTBg5zk_mVs9DD8-XpljQms",
          "validFulfillment": "UNlJ98hZTY_dsw0cAqw4i_UN3v4utt7CZFB4yfLbVFA",
          "validIlpPacket2": "AYIC9AAAAAAAABdwHWcucGF5ZWVmc3AubXNpc2RuLjIyNTU2OTk5MTI1ggLKZXlKMGNtRnVjMkZqZEdsdmJrbGtJam9pWmpRMFltUmtOV010WXpreE1DMDBZVGt3TFRoa05qa3RaR0ppWVRaaVl6aGxZVFpqSWl3aWNYVnZkR1ZKWkNJNklqVTBaRFZtTURsaUxXRTBOMlF0TkRCa05pMWhZVEEzTFdFNVkyWXpZbUl5TkRsaFpDSXNJbkJoZVdWbElqcDdJbkJoY25SNVNXUkpibVp2SWpwN0luQmhjblI1U1dSVWVYQmxJam9pVFZOSlUwUk9JaXdpY0dGeWRIbEpaR1Z1ZEdsbWFXVnlJam9pTWpJMU5UWTVPVGt4TWpVaUxDSm1jM0JKWkNJNkluQmhlV1ZsWm5Od0luMTlMQ0p3WVhsbGNpSTZleUp3WVhKMGVVbGtTVzVtYnlJNmV5SndZWEowZVVsa1ZIbHdaU0k2SWsxVFNWTkVUaUlzSW5CaGNuUjVTV1JsYm5ScFptbGxjaUk2SWpJeU5UQTNNREE0TVRneElpd2labk53U1dRaU9pSndZWGxsY21aemNDSjlMQ0p3WlhKemIyNWhiRWx1Wm04aU9uc2lZMjl0Y0d4bGVFNWhiV1VpT25zaVptbHljM1JPWVcxbElqb2lUV0YwY3lJc0lteGhjM1JPWVcxbElqb2lTR0ZuYldGdUluMHNJbVJoZEdWUFprSnBjblJvSWpvaU1UazRNeTB4TUMweU5TSjlmU3dpWVcxdmRXNTBJanA3SW1GdGIzVnVkQ0k2SWpZd0lpd2lZM1Z5Y21WdVkza2lPaUpWVTBRaWZTd2lkSEpoYm5OaFkzUnBiMjVVZVhCbElqcDdJbk5qWlc1aGNtbHZJam9pVkZKQlRsTkdSVklpTENKcGJtbDBhV0YwYjNJaU9pSlFRVmxGVWlJc0ltbHVhWFJwWVhSdmNsUjVjR1VpT2lKRFQwNVRWVTFGVWlKOWZRAA",
          "NORESPONSE_SIMPAYEE_NAME": "${internal_sim_prefix}noresponsepayeefsp",
          "SIM1_NAME": "${internal_sim_prefix}testfsp1",
          "SIM2_NAME": "${internal_sim_prefix}testfsp2",
          "SIM3_NAME": "${internal_sim_prefix}testfsp3",
          "SIM4_NAME": "${internal_sim_prefix}testfsp4",
          "SIM1_MSISDN": "17039811903",
          "SIM2_MSISDN": "17039811904",
          "SIM3_MSISDN": "17891239873",
          "SIM4_MSISDN": "17891239872",
          "SIM1_JWS_KEY": "-----BEGIN PRIVATE KEY-----\n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\nDgoQeSng2kt5Z6mkoDIQTs7nEflb4w==\n-----END PRIVATE KEY-----\n",
          "SIM2_JWS_KEY": "-----BEGIN PRIVATE KEY-----\n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\nTv4G862WYeqD1fdyZaKQ3b9fAQEq1g==\n-----END PRIVATE KEY-----\n",
          "SIMPAYEE_JWS_PRIVATE_KEY": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMu126miewCUCT\n7f49B0SyCPFGzmqGSs9rTPbk1se+BBhqfhsfkZj6cRRfrlg3rme6we0Ib2AF5TQL\nnoSBlDAimQcNOHXrqpAY/B0l/mgyUwmfv0NJ3UjZuCFuw3HRrU/oSUfXoDITC+Bi\n120w4FY2B/vPn+1iC/tsaCayneoaV/Sedq7H9+smEnQfGl3p5QJp/B2Ws3Bz1HqI\nIoxLEaO9VMeDHQPvNJn/7g9erqA5vIhmgLS46worOVjdRLH2SECH73qp8Wg0rJ8Y\neW2kQ8kuY4uHcG3MO6drYrC011U0ZyM90KV7dv2Y0h2FHlpn9s/pmb630m5ELpnB\nT/pYTLcXAgMBAAECggEADqk6Qz3SgBeMMYEWYZ4ZdsW6Ktpm+Xqg/kDy4JywOB9z\nSikBXeeKH3Z6ltwq2BicDV020Wb8Zt+s3vTOmLhDzC544/hPmtKfjWfR2eHX6gaq\nm+8ml+20pQFmb4Kn2MlC/Xzwm/SOXBvPyUmTua95rQExsK12DT0+F4YhLfhYsTh2\nHfkEzdFW4rrd+9ddKG1ZANS4ZaiMyzhtvUWeEBypBtVf+kBk+51t9pLCdjuynb8I\nWylSDhikT3/YQ/3g/Sz3SMp1u4x0GQe9FWYrnPzzp5LnM5fm49v8JWVHUvd0TOi0\ndQV+LYlgSD38YPpi4iKQSh0Zf0EBfbA83GsX2ArJ7QKBgQDmvcA6PqPo0OV/7RKY\nJuziA3TpucL8iVM1i7/Lv6+VkX88uDvEjwLoNAiYcgIm/CMK7WAwA+Dzn4r38EHB\nBKF4KRhP0qQS0KLXsd0tdsmAB0In7+cbKL4ttqNUP98xZAkTLJq9PXqTKN0qtyw4\nSfIsVMjDGoeSdWHObZYbGKICfQKBgQDjJLwolDrVX29V4zVmxQYH5iN+5kwKXHXj\nsuHBrW02Oj/GQFh3Xj6JQi3mzTWYhHwhA4pdaQtNYqTaz9Ic/O1VNPic2ovtg+cd\n7sh86qdQ4QZYhN3RT4oX///u6+UK90llh9hEBo3GuZ4X47tuByNtD4SFAlULrkSm\nfW4XaC3gIwKBgGil6HfCDx65F00UnVlKVicPQEf8ivVz5rwjPIJQ1nZ0PYuxVtIH\ntl7PspJJKra5pb7/957vM2fqlOFsIrZCvmS75p3VP7qUyzYeIdzLwgmBwTxRrrP/\nn3kmGx9LtJM29nKuySNIrb3uS5hi6PhCeUYn0cHC13fSKuCvjOOPIXMVAoGBAJg+\nCPdR0tUs8Byq+yH0sIQe1m+5wAG50zJYtUPxD6AnDpO8kQ8A1f19o/JsXJ3rPp+K\nFfVh8LdfhIs8e+H+DLztkizftqXtoLzJTQuc46QsDurJszsVisNnTI1BAvWEpWct\n0+BUXDZ0NuhgNUIb+rygh/v2gjYgCddlfqKlqwntAoGBAM5Kpp5R0G0ioAuqGqfZ\nsHEdLqJMSepgc6c7RC+3G/svtS2IqCfyNfVMM3qV5MY3J7KnAVjGOw2oJbXcPLXa\nuutsVVmPx2d/x2LZdc8dYYcdOQZvrUhmALhAPXM4SRujakxh+Uxi1VOiW+fZL8aW\nuu1pxuWD0gTJxFkp6u4YIAhw\n-----END PRIVATE KEY-----\n",
          "SIMPAYER_JWS_PRIVATE_KEY": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCg9eU66hg4ZAE6\njM4U8ylXQwUz9cdmzS3JyW+1bbgv77peMKSU/wFsi4QRwmbrYze9baFnGCKnS75E\nvCchib5vJxp3MDWzi/TGxmzgWdJRzkyCiI5C6dCgVL71MjsFgN3TN63wEf5sEU2I\neoJ8yXJM0pUG9f9NO7p/IGliDmt6C7EA7D9kQWigufmX0ZTVNKI07fKwC/AEKLp7\nkx99pvsCq8m184EEL15Q/NhA7R/5zKoHvmJa6Jd7tM0i0xn8IKOkNVFu3YIafAEC\nQWQwRbanFEeRc3tH3bEoYM8c74r+W+YxCG7nUf16XCk132XVffbHVl+wFgo18YB/\nsAJmcbePAgMBAAECggEAGQGKnsf+gkg7DqMQYx3Rxt5BISzmURjAK9CxG6ETk9Lt\nA7QP5ZvmVzwnhPDMN3Z/Et1EzXTo8U+pnBkVBTdWkAMlr+2b8ixklzr9cC9UJuRj\na4YWf9u+TyJLVmF63OSD0cwdKCZLffOENZc+zW8oZDn08BNomdGVLCnXZWXzGY8X\nKaJTJr29jEgkKOqFXdAHrsmj7TBtqSLZKx2IHdCmi05+5JCxVLPgnDiCicZ9zEii\nyWw57Q1migFIcw6ZQP4RyjgH1o70B+zo3OL7IQEirE17GUgK16XD8xi8hWCYTj5n\nxOz9yfVfPuYom/9Xbm5kYJZKE2HOZ3Lg8pUnWncuNQKBgQDbaOoACQPhVxQK1qYR\nRbW0I5Rn0EDxzsFPEpu3eXHoIYGXi8u/ew9AzFmGu+tKYJV5V4BCXo5x2ddE+B8B\ndXhyHLGfeV8tWKYKBpatolVxxKDL/9fnxoGIAO9cc91ieOm5JxmKscCVP1UnOXHZ\nuomSfAbGQwYDtMd2bJKkE1z0qwKBgQC7zacuv1PMaDFksHuNNRG+aZ74pJ77msht\nvJoKyaQcktD0xmIXhFfJvK4cclzG7s5jxCsu2ejimgmfVzgXlLEMrJFvSdFkD2SS\ngGqoxq5c9g8ssvt7xwr7aJ+VYYWTWRzJrOUny+99UbwHedu0EHL1BYILwy67Lium\nsgUeeCEgrQKBgGv+7f7qcRB/jgvvr3oc990dDjUzGmRrQlcrb54Vlu2NYH45fyZW\n6iEY9JAO+zd25tv9J9KDPFXpxb3a61gKfCie2wcF9MUbN08EAzKgDrKa+BKxcZJR\n8PwCic7V8QhBP7m09yt/Zq2PqNhPvCxRVtnVVnhMES/N0cgGlP9R0JVVAoGAHU2/\nkmnEN5bibiWjgasQM7fjWETHkdbbA1R0bM59zv+Rnz/9OlIqKI5KVKH7nAbTKXoI\niuzxi7ohWj2PwQ4wehvLLaRFCenk9X8YJXGq71Jtl7ntx6iNLCFtFS/8WbuD5GwX\n7ZfCrLk+L6RyBayzY0wSuKch+Y8AvKf2aISyFpkCgYEAjSfEjz9Cn+27HdiMoBwa\n+fyyoosci/6OBxj/WTKvV6KUYLBfFoAYpb9rqrbvnfyyc0UiAYQeMJAOWQ1kkzY4\nzXs63iPQi2UeGPJZ7RsT+31DSaG9YiQdrInsUrlm8hi1C7Pg/NNt6Y1G0WhWYrvF\niNK0yCENMhSoOTtbT9tmGi0=\n-----END PRIVATE KEY-----\n",
          "TESTFSP1_JWS_PUB_KEY": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2R3IuEDpqDtsS96emI0v\ndCJpeb/lnCxR2Nw5x6Z3GjC9PRFCJ2gsS2Zq70NaUQ5yWrrrZ9DZ8PjgCXqftUKG\n42uFsibLFpN09IjQuZCDuAkCdEjMgm+xies47ajRzl6evOc0ClkQBZVGybl9RAr6\nNRTFOYkYjJ0xS0MNkfRkDiOEu5BA/XKb5oLbyVMjGyvLgyS1g41x4fA+Ccb5PENa\nh9dqkFJ3j218Rs+bGytrVqrrCCjV1FiI+Y9YjKuTRRo7U/jcGHLfEc7YRcP2U9os\nxQxFvhHxR7W0e74fAU8B8YIJzwjaQvrEh9SJRc2IZsh6EdBAXXmbk4sHKyhoX0by\nUQIDAQAB\n-----END PUBLIC KEY-----\n",
          "TESTFSP2_JWS_PUB_KEY": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv7k0Mqy0jSXFpHD9/a+Y\nl5djXq6HdyC+BsSA/sRKczEBKQyW8mEJVILAKkOibWzK7e+SJjQPbFjgqiUZvRI5\n+ggHkSJXEV28Bi2sF58A15sQjwaSkE2vBwLAL5GftSmao0QSozSfQ+RFw2N+loRG\nYedXZpRMsYFr1uA1qavcBjoj7JqPpID7UaTgXwwHWbV+j2uhQfotqRvOQ5KTmx5H\nJa+VjPu+xAC7mmcL+dxmeBpbJJD5Li8B8ggJXGJUk+En6XSIgZkQ6vKvC9HyasE6\nWZLXU+JJoCp2wkCPNTRxzPE2PGnlI0a4ZP2/y/2yacc4HQGBhEMc+SVT/VSZaMS+\nAQIDAQAB\n-----END PUBLIC KEY-----",
          "payerfspSettlementAccountId": "",
          "payerfspSettlementAccountBalanceBeforeFundsIn": "",
          "payerfspSettlementAccountBalanceAfterFundsIn": "",
          "fundsInPrepareTransferId": "",
          "fundsInPrepareAmount": "",
          "SIMPLE_ROUTING_MODE_ENABLED": true,
          "mobileSimPayerFsp": "pinkbankfsp",
          "mobileSimPayeeFsp": "greenbankfsp",
          "ON_US_TRANSFERS_ENABLED": false,
          "expectedPartiesVersion": "1.0",
          "expectedParticipantsVersion": "1.0",
          "expectedQuotesVersion": "1.0",
          "expectedTransfersVersion": "1.0",
          "expectedAuthorizationsVersion": "1.0",
          "expectedTransactionRequestsVersion": "1.0",
          "toSubIdValue": "30",
          "fromSubIdValue": "30",
          "cgscurrency": "INR",
          "settlementtestfsp2bankMSISDN": "27713813915",
          "settlementtestfsp1bankMSISDN": "27713813914",
          "settlementtestfsp4bankMSISDN": "27713813917",
          "settlementtestfsp3bankMSISDN": "27713813916",
          "DELAY_CGS": 5000,
          "settlementpayeefspNoExtensionMSISDN": "27714923918",
          "NORESPONSE_NAME": "${internal_sim_prefix}noresponsepayeefsp",
          "payeefspMSISDN": "17039811907",
          "payerfspMSISDN": "17891239876",
          "settlementtestNonExistingMSISDN": "22244803917",
          "NET_DEBIT_CAP": "50000"
        }
      }

  ml-testing-toolkit-frontend:
    image:
      repository: mojaloop/ml-testing-toolkit-ui
      tag: v13.5.5
    ingress:
      hosts:
        ui: 
          host: ttkfrontend.${env}.${name}.${domain}.internal
          port: 6060
          paths: ['/']
    config:
      API_BASE_URL: http://ttkbackend.${env}.${name}.${domain}.internal:30000