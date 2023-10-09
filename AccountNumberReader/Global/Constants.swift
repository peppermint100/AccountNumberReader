//
//  Constants.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/27.
//

import Foundation

struct Constants {
    
    static let invalidBank = Bank(id: "", names: [], accountNumberRegex: [
        "\\d{12}",
        "\\d{13}",
        "\\d{14}",
    ])
    
    static let bankList: [Bank] = [
        Bank(
            id: "국민",
            names: [
                "KB",
                "KB국민"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{2}-\\d{4}-\\d{3}",
                "\\d{6}-\\d{2}-\\d{6}",
                "\\d{12}",
                "\\d{14}",
            ]),
        Bank(
            id: "기업",
            names: [
                "IBK",
                "IBK기업"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{6}-\\d{2}-\\d{3}",
                "\\d{14}",
            ]),
        Bank(
            id: "농협",
            names: [
                "NH농협",
                "NH"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{4}-\\d{4}-\\d{2}",
                "\\d{13}",
            ]),
        Bank(
            id: "신한",
            names: [
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{2}-\\d{6}",
                "\\d{3}-\\d{3}-\\d{6}",
                "\\d{11}",
                "\\d{12}"
            ]),
        Bank(
            id: "우리",
            names: [],
            accountNumberRegex: [
                "\\d{4}-\\d{3}-\\d{6}",
                "\\d{13}",
            ]),
        Bank(
            id: "하나",
            names: [
                "KEB",
                "KEB하나"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{6}-\\d{5}",
                "\\d{14}",
            ]),
        Bank(
            id: "외환",
            names: [
                "\\d{3}-\\d{6}-\\d{3}",
                "\\d{12}",

            ],
            accountNumberRegex: []),
        Bank(
            id: "시티",
            names: [
                "씨티"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{6}-\\d{3}",
                "\\d{12}",
            ]),
        Bank(
            id: "대구",
            names: [
                "DGB",
                "DBB대구"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{2}-\\d{6}-\\d{1}",
                "\\d{12}",
            ]),
        Bank(
            id: "부산",
            names: [
                "BNK",
                "BNK부산"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{4}-\\d{4}-\\d{2}",
                "\\d{13}",
            ]),
        Bank(
            id: "제일",
            names: [
                "SC제일",
                "SC",
                "STANDARDCHARTERD"
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{2}-\\d{6}",
                "\\d{11}",
            ]),
        Bank(
            id: "카카오",
            names: [
                "카뱅",
                "카카오뱅크",
                "KAKAO"
            ],
            accountNumberRegex: [
                "\\d{4}-\\d{2}-\\d{6}",
                "\\d{13}",
            ]),
        Bank(
            id: "케이",
            names: [
                "케이뱅크",
            ],
            accountNumberRegex: [
                "\\d{3}-\\d{3}-\\d{6}",
                "\\d{13}",
            ]),
    ]
}
