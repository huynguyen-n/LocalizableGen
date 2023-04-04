# LocalizableGen
The tool takes a lot of inspiration from [Poes](https://github.com/AvdLee/Poes).

A Swift command-line tool works with localizable file from Google Sheet. An easy way to help Business Analytics, Product Owner, Designer or non-tech will interact to the app with less involved from Developers.

LocalizableGen will helps you working with `Localizable.strings`(iOS) and `strings.xml`(Android):

- [x] Generate that files from Spreadsheet for each languages you selected.
- [x] Update the Spreadsheet from the files you already generated.

## Dependencies

Thanks a lot to all of dependencies I have used in this project. If not, this tool can not be done. 🙏🙏🙏

- [Auth Library for Swift](https://github.com/googleapis/google-auth-library-swift)
- [Swift Argument Parser](https://github.com/apple/swift-argument-parser)
- [SWXMLHash](https://github.com/drmohundro/SWXMLHash.git)
- [ColorizeSwift](https://github.com/mtynior/ColorizeSwift.git)

## Requirements

- Xcode 13 or above
- Log in to Google Sheet and make copy from [Template](https://docs.google.com/spreadsheets/d/1C2L-fsw-MiAyXdjzYl867UZfyjHFPpA5STBi88M26oo)
- Give the access from this email localizable-gen-service-accoun@localizable-generator.iam.gserviceaccount.com to your Spreadsheet.

## Setup Google Sheet

- Template have two sheets: ISO-639 and the base sheet template which include keys and values for each languages.

https://user-images.githubusercontent.com/21701724/178128774-e6437a9e-9ae1-41f9-ac7a-17bd89f28c52.mov



> **Note:** Before **Make a copy** from that template and login to Google Sheet you won't see the select option from B1 -> Z1 which I have set up for easy select the language.

<img width="1606" alt="Screen Shot 2022-07-10 at 08 59 57" src="https://user-images.githubusercontent.com/21701724/178128595-d1a1be18-5bde-4f4e-904d-fdb20cbde245.png">

## Usage

```
$ localizable-gen --help
OVERVIEW: A Swift command-line tool to generate localizable from Google
Sheet.localizable-gen-service-accoun@localizable-generator.iam.gserviceaccount.com

USAGE: localizable-gen <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  generate                Generate localizable file from your Spreadsheet.
  update                  Update current localizable file to your Spreadsheet.
```

### Installation using [Mint](https://github.com/yonaskolb/mint)
You can install LocalizableGen using Mint as follows:

```
$ mint install huynguyen-n/LocalizableGen
```

## Development

- Clone this repo
- Open Xcode by `Package.swift` file.

## FAQ

### Why is it "LocalizableGen"?
When app/module stable and not much feature in that Sprint. Frequently developers will be ask for update the strings file 🤔 I feel it's take time and would like to have a solution for that -> `LocaliableGen` came.

### What problem does it solve?
BA, PO or Designers will be ask to update the Spreadsheet. Developer will generate the `Localizable.strings` or `strings.xml` and replace the current file.

### Why is there a `LocalizableGenCore` framework?
This makes it really easy to eventually create a Mac App with a UI around it 🚀