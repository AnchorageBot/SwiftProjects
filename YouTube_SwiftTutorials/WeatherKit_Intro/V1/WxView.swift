//
//  WxView.swift
//  WxKitIntro_V1
//
//  Created by ATS and Claude on 3/27/24
//

/*
Abstract:
 
 A view that provides weather data for a location

References:
 
- About App Development with UIKit
    https://developer.apple.com/documentation/uikit/about_app_development_with_uikit
- UIKit Framework
    https://developer.apple.com/documentation/uikit
- Introduction to WeatherKit (iOS 16) – WWDC 2022 - iOS Academy
    www.youtube.com/@iOSAcademy
- Anthropic AI Claude
    https://www.anthropic.com
*/

import WeatherKit
import UIKit

// WeatherView is a custom UIView subclass that displays weather information
final class WeatherView: UIView {
    
    // MARK: - UI Components
    
    // iconView is an UIImageView that displays the weather icon
    private let iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        return image
    }()
    
    // titleLabel is an UILabel that displays the title of the weather information
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .medium)
        return label
    }()
    
    // tempLabel is an UILabel that displays the temperature value
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "37"
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 55, weight: .regular)
        return label
    }()
    
    // MARK: - Initialization
    
    // Initializes the WeatherView with a given frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        setupViews()
    }
    
    // Required initializer for NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    // Sets up the subviews and their constraints
    private func setupViews() {
        // Add iconView, titleLabel, and tempLabel as subviews
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(tempLabel)
        
        // Set up the constraints for the subviews
        NSLayoutConstraint.activate([
            // iconView constraints
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconView.heightAnchor.constraint(equalToConstant: 200),
            
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // tempLabel constraints
            tempLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
