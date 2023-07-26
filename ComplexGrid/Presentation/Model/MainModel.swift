//
//  Result.swift
//  ComplexGrid
//
//  Created by Sang hun Lee on 2023/07/25.
//

import Foundation

// MARK: - Response
struct Response: Decodable, Hashable {
    var page, total_results, total_pages: Int?
    var results: [Result]?
}

// MARK: - Result
/*
 "adult": false,
 "backdrop_path": "/kd3191bQRx5oNR7ZslUUNW37Kpw.jpg",
 "genre_ids": [
   28,
   9648,
   53
 ],
 "id": 54271,
 "original_language": "en",
 "original_title": "The Big Bang",
 "overview": "암울한 범죄 사건들에 지칠 대로 지친 사립탐정 크루즈. 그런 그에게 어느 날 권투선수 안톤 프로가 찾아와 감옥에서 펜팔로 만난 미모의 스트리퍼 렉시 퍼시몬을 찾아달라고 부탁한다. 사진과 함께 건네받은 편지 뭉치에서 여자가 안톤 프로에게서 받은 3천만 달러어치의 다이아몬드를 갖고 있다는 사실이 밝혀지고, 정체불명의 리무진 한 대가 크루즈를 쫓는 가운데 그가 만난 사람들이 모두 목숨을 잃는다. 추적 끝에 렉시가 사는 것으로 밝혀진 뉴멕시코의 사막에 도착한 크루즈는 우주 탄생의 비밀을 밝히겠다는 괴짜 갑부와 그를 돕는 천재 과학자, 그리고 렉시라고 알았지만 렉시가 아닌 한 여자와 그녀의 다이아몬드를 둘러싼 충격적인 사실이 밝혀진다.",
 "popularity": 7.153,
 "poster_path": "/tnr5dg4YGGCRgLr84noLmbQfiQS.jpg",
 "release_date": "2011-02-03",
 "title": "빅뱅",
 "video": false,
 "vote_average": 5.43,
 "vote_count": 115
 */
struct Result: Decodable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int?
    let backdrop_path: String?
    let title, overview: String?

    enum CodingKeys: String, CodingKey {
        case id, overview, backdrop_path, title
    }
}
