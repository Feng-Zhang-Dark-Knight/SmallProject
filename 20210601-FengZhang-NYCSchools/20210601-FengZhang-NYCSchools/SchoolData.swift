//
//  SchoolData.swift
//  20210601-FengZhang-NYCSchools
//
//  Created by Thales on 6/1/21.
//

import Foundation


struct School: Codable, Identifiable {
    var id: String
    let name: String
    let location: String
}


struct NewYorkSchools {
    var schools = [School]()
    
    // get school list in NYC via https
    func getSchools(completionHandler: @escaping ([School]) -> ()) {
    
        // append SQL syntax at the end of URL to extract useful fields
        let dataSourceURL =
            "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$select=dbn+AS+id,school_name+AS+name,location"
        
        guard let url = URL(string: dataSourceURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            // decode the JSON from URL to a shool list
            let schools = try! JSONDecoder().decode([School].self, from: data!)
            
            // it is an @escaping function
            completionHandler(schools)
        }
        .resume()
    }
    
}



struct SATScore: Codable {
    var school: String
    var math: String
    var writing: String
    var reading: String
}


struct SchoolSAT {
    var allScores = [SATScore]()

    func getAllScores(completionHandler: @escaping ([SATScore]) -> ()) {

        let dataSourceURL =
            "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$select=school_name+AS+school,sat_math_avg_score+AS+math,sat_writing_avg_score+AS+writing,sat_critical_reading_avg_score+AS+reading"
        
        guard let url = URL(string: dataSourceURL) else {
            print("something is wrong")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let scores = try! JSONDecoder().decode([SATScore].self, from: data!)
            print(scores)

            
                    completionHandler(scores)
                    print("score success")

        }
        .resume()
    }
    
    
    // get the score for a specific school
    func getSchoolScore(for school: School) -> SATScore {
        var schoolScore = SATScore(school: "", math: "", writing: "", reading: "")
        for score in self.allScores {
            if score.school == school.name.uppercased() {
                schoolScore = score
            }
        }
        return schoolScore
    }
}
