//
//  ViewModel.swift
//  20210601-FengZhang-NYCSchools
//
//  Created by Thales on 6/1/21.
//

import Foundation


class ViewModel: ObservableObject {
    @Published var newYorkSchools = NewYorkSchools()
    var schoolSAT = SchoolSAT()
    
    
    init() {
        newYorkSchools.getSchools { schools in
            self.newYorkSchools.schools = schools
        }
    
        schoolSAT.getAllScores { scores in
            self.schoolSAT.allScores = scores
        }
    }

    
    
    
}




