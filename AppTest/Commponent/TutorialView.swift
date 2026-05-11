//
//  TutorialModel.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 11/05/2026.
//


import SwiftUI

// MARK: - Models

public struct TutorialModel {
    public var theme: TutorialTheme?
    public var skippable: Bool?
    public var skipAction: (() -> Void)?
    public var fillBackground: Bool?
    public var itemModel: [TutorialItemModel]
    public var tutorialButton: TutorialButtonModel?
    public var style: TutorialStyle

    public init(
        itemModel: [TutorialItemModel],
        theme: TutorialTheme? = .light,
        skippable: Bool? = true,
        fillBackgroundImage: Bool? = true,
        skipAction: (() -> Void)? = nil,
        firstButton: TutorialButtonModel? = nil,
        style: TutorialStyle = .init()
    ) {
        self.theme = theme
        self.skipAction = skipAction
        self.skippable = skippable
        self.itemModel = itemModel
        self.tutorialButton = firstButton
        self.fillBackground = fillBackgroundImage
        self.style = style
    }
}

public struct TutorialItemModel {
    public var imageName: String?
    public var imageURL: String?
    public var title: String?
    public var desc: String?

    public init(imageName: String? = nil, imageURL: String? = nil, title: String? = nil, desc: String? = nil) {
        self.imageName = imageName
        self.imageURL = imageURL
        self.title = title
        self.desc = desc
    }
}

public enum TutorialTheme {
    case dark
    case light
}

public enum TutorialButtonState {
    case filled
    case outlined
}

public struct TutorialButtonModel {
    public var state: TutorialButtonState
    public var text: String
    public var buttonAction: (() -> Void)?

    public init(state: TutorialButtonState, text: String, buttonAction: (() -> Void)? = nil) {
        self.state = state
        self.text = text
        self.buttonAction = buttonAction
    }
}

// MARK: - Style Configuration

public struct TutorialStyle {
    public var textColor: Color
    public var backgroundColor: Color
    public var filledButtonTextColor: Color
    public var filledButtonBackgroundColor: Color
    public var outlinedButtonColor: Color
    public var buttonCornerRadius: CGFloat
    public var buttonBorderWidth: CGFloat
    public var titleFont: Font
    public var descriptionFont: Font
    public var skipText: String
    public var defaultButtonText: String
    public var pagerActiveColor: Color
    public var pagerInactiveColor: Color

    public init(
        textColor: Color = .primary,
        backgroundColor: Color = Color(.systemBackground),
        filledButtonTextColor: Color = .white,
        filledButtonBackgroundColor: Color = .blue,
        outlinedButtonColor: Color = .primary,
        buttonCornerRadius: CGFloat = 6,
        buttonBorderWidth: CGFloat = 2,
        titleFont: Font = .system(size: 30, weight: .bold),
        descriptionFont: Font = .system(size: 20, weight: .regular),
        skipText: String = "Skip",
        defaultButtonText: String = "Get Started",
        pagerActiveColor: Color = .primary,
        pagerInactiveColor: Color = .gray.opacity(0.4)
    ) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.filledButtonTextColor = filledButtonTextColor
        self.filledButtonBackgroundColor = filledButtonBackgroundColor
        self.outlinedButtonColor = outlinedButtonColor
        self.buttonCornerRadius = buttonCornerRadius
        self.buttonBorderWidth = buttonBorderWidth
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.skipText = skipText
        self.defaultButtonText = defaultButtonText
        self.pagerActiveColor = pagerActiveColor
        self.pagerInactiveColor = pagerInactiveColor
    }
}

// MARK: - Constants

private struct TutorialConstants {
    let defaultPadding: CGFloat = 16
    let pagerDotSize: CGFloat = 8
    let buttonHeight: CGFloat = 48
    let descriptionBottomPadding: CGFloat = 120
    let backgroundImageBottomPadding: CGFloat = 4
    let skipButtonPadding: CGFloat = 32
}

// MARK: - Tutorial View

public struct GenericTutorial: View {
    private var model: TutorialModel
    private let constants = TutorialConstants()
    private let dismissAction: (() -> Void)?
    @State private var currentIndex: Int = 0

    public init(model: TutorialModel, dismissAction: (() -> Void)? = nil) {
        self.model = model
        self.dismissAction = dismissAction
    }

    public var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<model.itemModel.count, id: \.self) { index in
                    TutorialItemView(
                        model: model.itemModel[index],
                        fillBackgroundImage: model.fillBackground ?? true,
                        style: model.style
                    )
                    .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            VStack(spacing: constants.defaultPadding) {
                if model.skippable == true {
                    skipButton
                }

                Spacer()

                if model.itemModel.count > 1 {
                    TutorialPager(
                        pages: model.itemModel.count,
                        selectedPage: currentIndex,
                        dotSize: constants.pagerDotSize,
                        activeColor: model.style.pagerActiveColor,
                        inactiveColor: model.style.pagerInactiveColor
                    )
                }

                tutorialButton
            }
            .padding(.vertical, constants.defaultPadding)
        }
        .statusBar(hidden: true)
        .background(model.style.backgroundColor)
        .environment(\.colorScheme, model.theme == .dark ? .dark : .light)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }

    private var tutorialButton: some View {
        Button(action: {
            model.tutorialButton?.buttonAction?()
            dismissAction?()
        }, label: {
            Text(model.tutorialButton?.text ?? model.style.defaultButtonText)
                .frame(maxWidth: .infinity)
                .frame(height: constants.buttonHeight)
        })
        .buttonStyle(
            TutorialButtonStyle(
                state: model.tutorialButton?.state ?? .filled,
                style: model.style
            )
        )
        .padding([.bottom, .horizontal], constants.defaultPadding)
    }

    private var skipButton: some View {
        HStack {
            Spacer()
            Button(action: {
                model.skipAction?()
                dismissAction?()
            }, label: {
                Text(model.style.skipText)
                    .foregroundColor(model.style.textColor)
                    .font(.title3)
            })
        }
        .padding(.horizontal, constants.defaultPadding)
        .padding(.vertical, constants.skipButtonPadding)
    }
}

// MARK: - Tutorial Item View

private struct TutorialItemView: View {
    let model: TutorialItemModel
    let fillBackgroundImage: Bool
    let style: TutorialStyle
    private let constants = TutorialConstants()

    var body: some View {
        if fillBackgroundImage {
            fullBackgroundContent
        } else {
            partialBackgroundContent
        }
    }

    private var fullBackgroundContent: some View {
        ZStack(alignment: .bottom) {
            if let imageUrl = model.imageURL, let url = URL(string: imageUrl) {
                imageView(url: url)
            }

            VStack(alignment: .center, spacing: constants.defaultPadding) {
                titleView
                descriptionView
            }
            .padding(.bottom, constants.descriptionBottomPadding)
            .foregroundColor(style.textColor)
        }
    }

    private var partialBackgroundContent: some View {
        VStack(alignment: .center, spacing: constants.defaultPadding) {
            if let imageUrl = model.imageURL, let url = URL(string: imageUrl) {
                imageView(url: url)
                    .padding(.bottom, constants.backgroundImageBottomPadding)
            }

            titleView
            descriptionView
        }
        .padding(.bottom, constants.descriptionBottomPadding)
        .foregroundColor(style.textColor)
    }

    private var titleView: some View {
        Text(model.title ?? "")
            .font(style.titleFont)
            .multilineTextAlignment(.center)
    }

    private var descriptionView: some View {
        Text(model.desc ?? "")
            .font(style.descriptionFont)
            .multilineTextAlignment(.center)
            .padding([.leading, .trailing], constants.defaultPadding)
    }

    private func imageView(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failure:
                if let imageName = model.imageName {
                    Image(imageName)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            default:
                if let imageName = model.imageName {
                    Image(imageName)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

// MARK: - Tutorial Pager

private struct TutorialPager: View {
    let pages: Int
    let selectedPage: Int
    let dotSize: CGFloat
    let activeColor: Color
    let inactiveColor: Color

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<pages, id: \.self) { index in
                Circle()
                    .fill(index == selectedPage ? activeColor : inactiveColor)
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}

// MARK: - Button Style

private struct TutorialButtonStyle: ButtonStyle {
    let state: TutorialButtonState
    let style: TutorialStyle

    func makeBody(configuration: Configuration) -> some View {
        switch state {
        case .filled:
            configuration.label
                .foregroundColor(style.filledButtonTextColor)
                .background(style.filledButtonBackgroundColor)
                .cornerRadius(style.buttonCornerRadius)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        case .outlined:
            configuration.label
                .foregroundColor(style.outlinedButtonColor)
                .background(Color.clear)
                .cornerRadius(style.buttonCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: style.buttonCornerRadius)
                        .stroke(style.outlinedButtonColor, lineWidth: style.buttonBorderWidth)
                )
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}

// MARK: - Overlay Modifier

struct TutorialOverlayModifier: ViewModifier {
    @Binding var model: TutorialModel?

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if let model {
                        GenericTutorial(
                            model: model,
                            dismissAction: {
                                self.model = nil
                            }
                        )
                    }
                }
            )
    }
}

public extension View {
    func tutorialOverlay(model: Binding<TutorialModel?>) -> some View {
        self.modifier(TutorialOverlayModifier(model: model))
    }
}

// MARK: - Preview

#Preview {
    struct TutorialPreview: View {
        @State private var model: TutorialModel?

        var body: some View {
            VStack(spacing: 20) {
                Text("Tutorial Demo")
                    .font(.title)
                    .padding()

                Button("Show Tutorial") {
                    model = TutorialModel(
                        itemModel: [
                            TutorialItemModel(
                                imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNt48HeOWDiyj4kkkP8mUvj2HFvPjI71A3SEQTb2cxQebCfAB1Z6cpE4tumdHcGxdzzy0&usqp=CAU",
                                title: "Welcome",
                                desc: "This is the first page of the tutorial."
                            ),
                            TutorialItemModel(
                                imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNt48HeOWDiyj4kkkP8mUvj2HFvPjI71A3SEQTb2cxQebCfAB1Z6cpE4tumdHcGxdzzy0&usqp=CAU",
                                title: "Easy to Use",
                                desc: "Simply add the tutorialOverlay modifier to any view."
                            ),
                            TutorialItemModel(
                                imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNt48HeOWDiyj4kkkP8mUvj2HFvPjI71A3SEQTb2cxQebCfAB1Z6cpE4tumdHcGxdzzy0&usqp=CAU",
                                title: "Get Started",
                                desc: "You're all set! Tap the button to begin."
                            )
                        ],
                        theme: .light,
                        skippable: true,
                        fillBackgroundImage: false,
                        skipAction: { print("Skipped") },
                        firstButton: TutorialButtonModel(
                            state: .filled,
                            text: "Get Started"
                        )
                    )
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tutorialOverlay(model: $model)
        }
    }

    return TutorialPreview()
}
