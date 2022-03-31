//
//  Constant.swift
//  
//
//  Created by Huy Nguyen on 31/03/2022.
//

import Foundation

enum Platform {
    case iOS
    case Android
}

struct Constant {

    struct App {
        static let targetName = ProcessInfo.processInfo.environment["TARGET_NAME"] ?? ""
        static let credentialKey = "GOOGLE_APPLICATION_CREDENTIALS"

        struct Message {

            static let intro = "A Swift command-line tool to generate localizable from Google Sheet."
            static let email = "Before to start, share your Spreadsheet with this email\nEmail:\t"
        }
    }

    struct LocaliableFile {

        struct iOS {

            static let dirExtension = "lproj"
            static let name = "Localizable.strings"
        }

        struct Android {
            static let name = "strings.xml"
        }
    }

    struct OAuth {
        static let scopes: [String] = [ "https://spreadsheets.google.com/feeds",
                                        "https://www.googleapis.com/auth/drive" ]
        struct Credentials {
            static let type: String = "service_account"
            static let projectId: String = "localizable-generator"
            static let privateKeyId: String = "2195c5a5862763d802a0878eeef50de5a579f645"
            static let privateKey: String = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCtiN6BTanyYwec\n2ifFcHzCarcnePPfe+HPho6nOgbFDKWtRMjQhHqCLZ+Dt3xTIY3EnHSSRMAoFjwH\nCJx1gsAY2ttgNbbNxluj7s0FnJlCJSZxVkUxQ3Zg0LXeIiWStOzHUUr8pIwWlS7R\nEky+sC0t62MpX/1KqN5PjO5wv4mktgc//obB9pmF/s4BJ7Qh6ut5GCqJHI3Mw9fG\nxvcqlEv8+LUE4cP1ezi5mbwu4wyUiIaM/PMjHn4i33h9WgOm2mpVI8vcTZbTUAw1\nWktMGgKZqm6aCMbDnCts7KdnjUeybWKD1sqBT/XShIsQgaqXAQCIZ+84uuzZf6tW\nPxx2yyZ7AgMBAAECggEAGVSEAgTHnJlcQvF3DQiqiqhlZq4ZjugNdyt8HCh0qi5P\n6qxCfGlcsS7JUhfQ3m455taIOieDPaFijrZGPELjGQhX2EHO7AIbCKFIAkcwTxQ5\necwEGo5EiRo99G2F5YBiRYUguHhToyI7LLUKnb+n60Qo0SEb9FoU5TC8R0SLag69\nayyofx/dyjPjgmO5acEznd8Sfw7N3oLOQXQUqm1NolwTavbBPewRgrOiqGIPtb7z\ndgnxWvel70zjDu3cA+hdqPW2qS1lNqEhi+Bq/PhK1gNYA9CjaTWpgHRBdUaVNly5\n6JPay3F59D3Ru7wZZeNZ9vTLGe5xe6r4pT6ePmC4FQKBgQDpwop5rxlGAVlds3i4\nTBW8opGzPmm2hzGm0aPJOp1gfkjZoms6cb9LvyexVNvYLF7JmZa9vo0DgEYQJln9\nf915uir71fsR/6+0j+dyWqYQ4x1H2SEJa62EIgJBk5kwLVXhFpCqJH3zBcPCxvja\nernUEOL1ypFXkfigtQ9wxKfTDwKBgQC+C3sP9NDN7OyvIp+R+nO7WVmlFvhyuzLf\n96qPX7b6NF//ziUEiNdyW1IezAonpIE21XzNWBaxgEGc8GMnFDkNWMufmocRJIrV\n0K+4CgHs4QeVBbnVg0GdpGbjQqGfr4lQEkwiGl2XDMDobiFNZ9y48wcf9KYHRziR\n57LkumLF1QKBgQDoL9vr0giAiIaDk+is5qYQoEmoiK3oJ5Eh6cmN7zKyzbz+r11i\nx+kDC/QZJ/jWV/wusugPwF3AxIDTOcTZD1ClwE1Bp+Gilx2nc+iopXGeBHjpDLrL\n6LCJNl6XVEwslltfIFLBLU4NPgScS5aTLKO4CK3nBjYnjU4wEqgrkqo/8QKBgAYq\n+zh+WpSEXv4kIoerWDw5XyZzg2a92p3YPOngUmD2eDMmLp9iDZQBkL29I4s71JHC\nBgXoGPxzzC1aw+0Nw/hB7IHmkwGkbPkZh8pyULOubf+RKwHZ+7QxFMHFdNdo7Az0\nOxJURrtTR6ODh4MqnshF4vJPj1/nGNfrbCvuPKxtAoGBANllfyJ9y9yRIVcT2m35\nAM+Tw+AZ391YNY9WbnDP9DJZKeq/TcGkyhl0SMboBiwKWZmlUTWGUKkfFa8Ik8+R\ngj5LzMESHbwQf6fdY8uTexM8ucRpdUEOCbuHAx/Dl4mWYQmGUKpLIgt7O/Png5Yg\np0Bo/CLt6i8WUhv4rxWFXHYJ\n-----END PRIVATE KEY-----\n"
            static let clientEmail: String = "localizable-gen-service-accoun@localizable-generator.iam.gserviceaccount.com"
            static let clientID: String = "115584901428080335007"
            static let authURI: String = "https://accounts.google.com/o/oauth2/auth"
            static let tokenURI: String = "https://oauth2.googleapis.com/token"
            static let authProviderX509CertURL: String = "https://www.googleapis.com/oauth2/v1/certs"
            static let clientX509CertURL: String = "https://www.googleapis.com/robot/v1/metadata/x509/localizable-gen-service-accoun%40localizable-generator.iam.gserviceaccount.com"
        }
    }
}

