//
//  Constants.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/09.
//

import Foundation

struct Constants {
    static let bankList: [Bank] = [
        Bank(
            id: "국민",
            names: [
                "KB",
                "KB국민"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{2}-\\d{4}-\\d{3})\\b",
                "\\b(\\d{6}-\\d{2}-\\d{6})\\b",
                "\\b(\\d{12})\\b",
                "\\b(\\d{14})\\b",
            ]),
        Bank(
            id: "기업",
            names: [
                "IBK",
                "IBK기업"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{6}-\\d{2}-\\d{3})\\b",
                "\\b(\\d{14})\\b",
            ]),
        Bank(
            id: "농협",
            names: [
                "NH농협",
                "NH"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{4}-\\d{4}-\\d{2})\\b",
                "\\b(\\d{13})\\b",
            ]),
        Bank(
            id: "신한",
            names: [
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{2}-\\d{6})\\b",
                "\\b(\\d{3}-\\d{3}-\\d{6})\\b",
                "\\b(\\d{11})\\b",
                "\\b(\\d{12})\\b"
            ]),
        Bank(
            id: "우리",
            names: [],
            accountNumberRegex: [
                "\\b(\\d{4}-\\d{3}-\\d{6})\\b",
                "\\b(\\d{13})\\b",
            ]),
        Bank(
            id: "하나",
            names: [
                "KEB",
                "KEB하나"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{6}-\\d{5})\\b",
                "\\b(\\d{14})\\b",
            ]),
        Bank(
            id: "외환",
            names: [
                "\\b(\\d{3}-\\d{6}-\\d{3})\\b",
                "\\b(\\d{12})\\b",
                
            ],
            accountNumberRegex: []),
        Bank(
            id: "시티",
            names: [
                "씨티"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{6}-\\d{3})\\b",
                "\\b(\\d{12})\\b",
                
            ]),
        Bank(
            id: "대구",
            names: [
                "DGB",
                "DBB대구"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{2}-\\d{6}-\\d{1})\\b",
                "\\b(\\d{12})\\b",
            ]),
        Bank(
            id: "부산",
            names: [
                "BNK",
                "BNK부산"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{4}-\\d{4}-\\d{2})\\b",
                "\\b(\\d{13})\\b",
            ]),
        Bank(
            id: "제일",
            names: [
                "SC제일",
                "SC",
                "STANDARDCHARTERD"
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{2}-\\d{6})\\b",
                "\\b(\\d{11})\\b",
            ]),
        Bank(
            id: "카카오",
            names: [
                "카뱅",
                "카카오뱅크",
                "KAKAO"
            ],
            accountNumberRegex: [
                "\\b(\\d{4}-\\d{2}-\\d{6})\\b",
                "\\b(\\d{13})\\b",
            ]),
        Bank(
            id: "케이",
            names: [
                "케이뱅크",
            ],
            accountNumberRegex: [
                "\\b(\\d{3}-\\d{3}-\\d{6})\\b",
                "\\b(\\d{13})\\b",
            ]),
    ]
}
