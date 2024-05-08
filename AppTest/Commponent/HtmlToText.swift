//
//  HtmlToText.swift
//  AppTest
//
//  Created by ahmed hussien on 13/03/2024.
//

import Foundation
import SwiftUI
import MijickNavigattie

struct HtmlToTextView:NavigatableView {
    var htmlTextEngalish = "<p><span style='color: #3366ff;'><strong>About YC FACE MASK BAMBOO CHARCOAL:</strong></span></p><p><span>Specially formulated Mask with Bamboo Charcoal that deep cleans oil and dirt from pores, allowing moisture to be absorbed into the skin, this vitalizing facial mask gently cleanses away oil, bacteria, deep cleans and naturally draws pore-clogging dirt from the skin.</span></p><p><strong><br /> Formula: Face Mask</strong></p><p><strong>Origin: Thailand&nbsp;</strong></p><p><strong> Volume: 100 Ml</strong><span>&nbsp; &nbsp; &nbsp; &nbsp;</span></p><p><span style='color: #3366ff;'><strong>Description</strong><strong>:</strong></span></p><p><span>YC Bamboo Charcoal Black Peel-off Mask removes blackheads, acne, redness. Enriched with powerful nutrient-rich ingredients, the mask retains moisture leaving your skin smooth, soft, bright and radiant every day. It contains powerful bamboo extracts that effectively removes pore-clogging dirt while protecting the skin from blackheads and tightening skin for a cleaner and clearer appearance.</span></p><p><span style='color: #3366ff;'><strong> How to use?</strong></span></p><ol><li><span> Simply clean your face thoroughly and then apply a thick layer over your skin.</span></li><li><span> Allow the face mask to dry then peel from top to bottom and moisturize to achieve an instantly fresh face</span></li></ol><p><span style='color: #3366ff;'><strong><span>Bamboo Extract features</span></strong><strong>:</strong></span></p><p><span>Helps to remove blackheads, acne, redness, and blemishes. Removes pore-clogging dirt while protecting the skin from blackheads and tightening skin for a cleaner and clearer appearance.</span></p>"
    
    var htmlTextArabic =  "<p style='text-align: right;' dir='rtl'><span style='text-align: right; color: #3366ff;'><strong>ما هو</strong> <strong>واي سي قناع وجه </strong><strong>بفحم الخيرزان الشنط ؟</strong></span></p>\n<p style='text-align: right;' dir='rtl'><span>قناع مُصمم خصيصًا من فحم الخيزران الذي ينظف عميقًا الزيت والأوساخ من مسام البشرة ، مما يسمح باستعادة الترطيب في البشرة.</span></p>\n<p style='text-align: right;' dir='rtl'><span>ينظف هذا القناع و ينعش الوجه بلطف ويزيل الافرازات الدهنية والبكتيريا ويزيل بشكل طبيعي الأوساخ التي تسد المسام من الجلد.</span></p>\n<p style='text-align: right;' dir='rtl'><strong>الفئة: </strong>قناع للوجه</p>\n<p style='text-align: right;' dir='rtl'><strong>الاستخدام: </strong>قناع يساعد علي تنقية البشرة وإزالة النمش واعطاء البشرة مظهر أكثر نضارة.</p>\n<p style='text-align: right;' dir='rtl'><strong>الحجم: </strong>100 مل</p>\n<p style='text-align: right;' dir='rtl'><strong>بلد المنشأ:</strong> تايلاند</p>\n<p style='text-align: right;'><span style='text-align: right; color: #3366ff;' dir='rtl'><strong>&nbsp;وصف المنتج: </strong></span></p>\n<p style='text-align: right;' dir='rtl'><span>يزيل الرؤوس السوداء ، حب الشباب ، الاحمرار ، والعيوب. غني بالمكونات القوية الغنية بالمواد الغذائية ، يعيد القناع الرطوبة للبشرة بعد تنظيف المسام مما يجعل بشرتك ناعمة ومشرقة كل يوم.</span></p>\n<p style='text-align: right;' dir='rtl'><span>يحتوي القناع على مقتطفات قوية من الخيزران التي تزيل الأوساخ المسدودة بشكل فعال مع حماية البشرة من الرؤوس السوداء وتدعيم الجلد للحصول على مظهر نظيف وصحي وأكثر وضوحًا</span><span>.</span></p>\n<p style='text-align: right;'><span style='text-align: right; color: #3366ff;' dir='rtl'><strong>&nbsp;مميزات استخدام الخيرزان:</strong></span></p>\n<p style='text-align: right;' dir='rtl'><span>يساعد على إزالة الرؤوس السوداء وحب الشباب والاحمرار والعيوب. يزيل الأوساخ التي تسد المسام مع حماية البشرة من الرؤوس السوداء </span><span>وتضييق المسام</span><span> للحصول على مظهر أنظف وأكثر وضوحًا</span><span>.</span></p>\n<p style='text-align: right;'><span style='text-align: right; color: #3366ff;' dir='rtl'><strong>كيفية الاستخدام:</strong></span></p>\n<ul style='text-align: right;' dir='rtl'>\n<li><strong> </strong><span>قم ببساطة بتنظيف وجهك جيدًا ثم ضع طبقة سميكة على بشرتك</span><span>.</span></li>\n<li><strong> </strong>اتر<span>ك قناع الوجه حتى يجف ثم قشره من أعلى إلى أسفل واغسل البشرة من أي بقايا تبقت علي بشرتك من القناع.</span></li>\n</ul>"
    var body: some View {
        VStack {
            Link("Stackoverflow", destination: URL(string: "https://stackoverflow.com")!)
//            Text(htmlTextArabic)
//                .padding()
            TextCustom(html: htmlTextArabic)
                .padding()
//            HTMLText(html: htmlTextArabic)
//                .padding()
//            Text(convertToAttributedString(html: htmlTextArabic) ?? AttributedString(""))
//                .padding()
//            Text("\(convertToNSMutableAttributedString(html: htmlTextArabic) ?? NSMutableAttributedString(""))")
//                .padding()
            
            // Convert HTML string to attributed string
            if let attributedString = htmlTextArabic.convertToAttributedString() {
                Text("\(attributedString)").padding()
            } else {
              
            }
            
        }
    }
}

// Using UITextView
struct TextCustom: UIViewRepresentable {
    let html: String
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
        DispatchQueue.main.async {
            let data =   html.data(using:.utf16)!  //Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html],documentAttributes: nil) {
                uiView.isEditable = false
                uiView.attributedText = attributedString
            }
        }
    }
  func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
    let label = UITextView()
    return label
  }
}
private func convertToAttributedString(html:String)->AttributedString?{
    if let nsAttributedString = try? NSAttributedString(data: html.data(using:.utf16)!, options: [.documentType: NSAttributedString.DocumentType.html],documentAttributes: nil),
       let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
        return  attributedString
    }else{
        return nil
    }
}
extension String {
    func convertToAttributedString() -> NSAttributedString? {
        if let data = self.data(using: .utf16) {
            do {
                let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                return attributedString
            } catch {
                print("Error converting HTML to attributed string: \(error)")
                return nil
            }
        }
        return nil
    }
}

// Using UILabel
struct HTMLText: UIViewRepresentable {
   let html: String
   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        DispatchQueue.main.async {
            let data =  html.data(using: .utf16)!
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

#Preview {
    HtmlToTextView()
}
