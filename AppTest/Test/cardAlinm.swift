private var termsAndDetailsView: some View {
        Button(action: {
            self.viewModel.navigateToTermsAndDetails()
        }) {
            VStack{
                VFImage(
                    name: constants.Images.termsIcon,
                    maxWidth: constants.Layout.maxWidthTermsImage,
                    maxHeight: constants.Layout.maxHeightTermsImage
                )
                
                VFText(constants.Texts.termsAndFAQ)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(constants.Layout.termsAndDetailsRadius)
            .shadow(color: Color.black.opacity(constants.Layout.cardShadowOpacity), radius: constants.Layout.cardShadowRadius, x: 0, y: constants.Layout.cardShadowY)
        }
        .frame(maxWidth: .infinity)
        
    }
    
    private var DeleteCardView: some View {
        Button(action: {
            self.showDeleteCardConfirmation()
        }) {
            VStack {
                VFImage(
                    name: constants.Images.deleteCardicon,
                    width: constants.Layout.maxWidthTermsImage,
                    height: constants.Layout.maxHeightTermsImage
                )
                
                VFText(constants.Texts.deleteCardtitle)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(constants.Layout.deleteCardRadius)
            .shadow(color: Color.black.opacity(constants.Layout.cardShadowOpacity), radius: constants.Layout.cardShadowRadius, x: 0, y: constants.Layout.cardShadowY)
        }.frame(maxWidth: .infinity)
        
    }
    