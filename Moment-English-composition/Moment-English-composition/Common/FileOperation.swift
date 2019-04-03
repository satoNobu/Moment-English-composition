//
//  FileOperation.swift
//  Moment-English-composition
//
//  Created by 信次　智史 on 2019/03/31.
//  Copyright © 2019 stoshi nobutsugu. All rights reserved.
//

import Foundation

class FileOperation {
    
    // csvをStringの配列に変換
    static func tsvLoad(fileName: String) -> [String] {
        // csvファイルを格納するための配列
        var csvArray: [String] = []
        // csvファイルの読み込み
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "tsv")
        do {
            // csvBundleのパスを読み込み、UTF8に文字コードw変換してNSStringに格納
            let tsvData = try String(contentsOfFile: csvBundle!,
                                     encoding: String.Encoding.utf8)
            // 改行コードが\n1つになるようにする
            var lineChange = tsvData.replacingOccurrences(of: "\r", with: "\n")
            lineChange = lineChange.replacingOccurrences(of: "\n\n", with: "\n")
            // "\n"の改行コードを区切って、配列csvArrayに格納する
            csvArray = lineChange.components(separatedBy: "\n")
        } catch {
            print("CSV変換エラー")
        }
        return csvArray
    }
}
