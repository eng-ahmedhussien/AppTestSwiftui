//
//  VCNRevampScreen.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 09/02/2026.
//

import SwiftUI

struct VCNRevampScreen: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                
            }
        }
    }
}

extension VCNRevampScreen{
    func setupHeaderView(vcnMainPageViewModel:VCNMainPageContentModel){
        guard let background = vcnMainPageViewModel.backgroundImgUrl else {
            hideHeaderView()
            return
        }
        
        self.VCNImageView.setContentImage(named:background, imagePathUrl: Constants.imagePathUrl())
    }
    
    private func hideHeaderView() {
        self.VCNImageView.isHidden = true
        self.VCNImageView.snp.makeConstraints { make in
            make.height.equalTo(0)
        }
        self.view.layoutIfNeeded()
    }
}

#Preview {
    VCNRevampScreen()
}
