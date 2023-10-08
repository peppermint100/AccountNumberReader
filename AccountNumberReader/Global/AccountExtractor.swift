//
//  AccountExtractor.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/27.
//

import Foundation

class AccountExtractor {

    static let shared = AccountExtractor()
    private init() {}

    func getAccountNumber(from text: String) {
        // 설정 값 가져오기
        let copyScope = SettingsManager.shared.getCopyScope()
        let includeHyphen = SettingsManager.shared.getIncludeHyphen()
        
        // 은행 정보 가져오기
            // 있는 경우
                // 해당 은행 Regex로 계좌번호 추출
                    // 추출 가능한 경우
                        // return
                    // 추출 불가능한 경우
                        // 12~14자리 번호 앞에부터 return
            // 없는 경우
                // 12~14자리 번호 앞에부터 return
    }

    func extractAccountInfo(from text: String) -> (String, String)? {
        do {
            // \\b => 단어 경계
            let regex = try NSRegularExpression(pattern: "\\b(\\d{4}-\\d{4}-\\d{4}-\\d{4})\\b", options: [])
            let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))

            if let match = matches.first, let accountRange = Range(match.range, in: text) {
                let accountNumber = String(text[accountRange])

                // 여기에 은행 이름을 추출하는 로직을 추가하세요.
                // 예를 들어 정규 표현식을 사용하거나 특정 키워드를 검색할 수 있습니다.
                
                // 은행 이름 추출 예제:
                // let bankRegex = try NSRegularExpression(pattern: #"(\b은행이름1\b)|(\b은행이름2\b)|(\b은행이름3\b)"#, options: [])
                // let bankMatches = bankRegex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
                // if let bankMatch = bankMatches.first {
                //     let bankName = String(text[Range(bankMatch.range, in: text)!])
                // }
                // 은행 이름을 추출하는 로직을 추가하세요.
                let bankName = "은행 이름을 추출하는 로직을 추가하세요"

                return (accountNumber, bankName)
            }
        } catch {
            print("정규 표현식 오류: \(error)")
        }

        return nil
    }
}
