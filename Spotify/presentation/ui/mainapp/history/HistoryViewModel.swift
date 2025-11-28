//
//  HistoryViewModel.swift
//  Spotify
//
//  Created by Hồ Hải Hà on 28/11/25.
//

import Foundation

class HistoryViewModel {
    private let getHistoryUseCase: GetHistoryUseCase
    
    init(getHistoryUseCase: GetHistoryUseCase) {
        self.getHistoryUseCase = getHistoryUseCase
    }
    
    func getHistory() -> [Song] {
        return getHistoryUseCase.execute()
    }
}
