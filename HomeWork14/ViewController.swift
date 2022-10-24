//
//  ViewController.swift
//  HomeWork14
//
//  Created by Darya Grabowskaya on 12.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var rabbitView: UIView!
    
    // MARK: - Private properties
    private let imageBackground = UIImage(named: "background")
    private var imageCarrot = UIImage(named: "carrot")
    private lazy var imageViewCarrot = UIImageView(image: imageCarrot)
    private lazy var imageViewCarrotSecond = UIImageView(image: imageCarrot)
    private var imageChili = UIImage(named: "chili")
    private lazy var imageViewChili = UIImageView(image: imageChili)
    private var isFirstLoad = true
    private var rabbitSize: CGFloat = 0
    private var defaultSpacing: CGFloat = 0
    private var isGaming = true
    private var rabbitLocation: Location = .center {
        willSet (newLocation) {
            layoutRabbit(at: newLocation)
        }
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vsc = navigationController?.viewControllers else { return }
        guard vsc.first(where: { vc in (vc as? StartRabbitViewController) != nil}) is StartRabbitViewController else { return }
        
        view.backgroundColor = UIColor(patternImage: imageBackground ?? UIImage())
        imageViewCarrot.frame = CGRect(x: 30, y: -100, width: 90, height: 90)
        imageViewCarrotSecond.frame = CGRect(x: 280, y: -190, width: 90, height: 90)
        imageViewChili.frame = CGRect(x: 150, y: -220, width: 75, height: 75)
        
        view.addSubview(imageViewCarrot)
        view.addSubview(imageViewCarrotSecond)
        view.addSubview(imageViewChili)
        setupRabbit()
        rabbitLocation = .center
    }
    
    override func viewWillLayoutSubviews() {
        if isFirstLoad {
            rabbitSize = 140
            defaultSpacing = (view.frame.width - rabbitSize * 3) / 4
            setupRabbit()
            view.addSubview(rabbitView)
            layoutRabbit(at: .center)
            isFirstLoad = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.3, delay: 0.4, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrot.frame.origin.y += self.view.frame.height + 150
        })
        UIView.animate(withDuration: 2.5, delay: 0.6, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrotSecond.frame.origin.y += self.view.frame.height + 300
        })
        UIView.animate(withDuration: 2.3, delay: 7, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewChili.frame.origin.y += self.view.frame.height + 320
        })
        
        intersects()
    }
    
    private func intersects() {
        guard isGaming else { return }
        if checkIntersect(rabbitView, imageViewChili) {
            imageViewCarrot.layer.removeAllAnimations()
            imageViewCarrotSecond.layer.removeAllAnimations()
            imageViewChili.layer.removeAllAnimations()
            isGaming = false
            showAlert(withTitle: "OOPS!", message: "Мне кажется, ты съел что-то не то. Начни игру заново 😉")
        }
        
        if checkIntersect(rabbitView, imageViewCarrot) {
            imageViewCarrot.isHidden = true
        }
        
        if checkIntersect(rabbitView, imageViewCarrotSecond) {
            imageViewCarrotSecond.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.intersects()
            
        }
    }
    
    private func makeNewCarrots() {
        imageViewCarrot.isHidden = false
        UIView.animate(withDuration: 2.5, delay: 0.6, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrotSecond.frame.origin.y += self.view.frame.height + 300
        })
        UIView.animate(withDuration: 2.5, delay: 0.6, options: [.curveEaseInOut, .repeat], animations: {
            self.imageViewCarrotSecond.frame.origin.y += self.view.frame.height + 300
        })
    }
    
    // не поняла, как мне тоже кролика вернуть на место
    override func viewDidLayoutSubviews() {
        //rabbitView.frame =
    }
    
    func showAlert(withTitle title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Вернуться в меню", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    private func checkIntersect(_ first: UIView, _ second: UIView) -> Bool {
        
        guard let firstFrame = first.layer.presentation()?.frame,
              let secondFrame = second.layer.presentation()?.frame else { return false }
        
        return firstFrame.intersects(secondFrame)
    }
    
    // MARK: - Private methods
    private func setupRabbit() {
        rabbitView.frame = CGRect(
            x: getOriginX(for: .center),
            y: view.frame.size.height - rabbitSize,
            width: rabbitSize,
            height: rabbitSize
        )
        
        addSwipeGesture(to: rabbitView, direction: .left)
        addSwipeGesture(to: rabbitView, direction: .right)
    }
    
    private func addSwipeGesture(to view: UIView, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveRabbit))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func moveRabbit(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        switch gestureRecognizer.direction {
        case .left:
            if rabbitLocation == .center {
                rabbitLocation = .left }
            if rabbitLocation == .right {
                rabbitLocation = .center }
        case .right:
            if rabbitLocation == .center {
                rabbitLocation = .right }
            if rabbitLocation == .left {
                rabbitLocation = .center }
        default:
            return
        }
    }
    
    private func layoutRabbit(at location: Location) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.rabbitView.frame.origin.x = self.getOriginX(for: location)
        }
        }
        
        private func getOriginX(for location: Location) -> CGFloat {
            switch location {
            case .left:
                return defaultSpacing
            case .center:
                return defaultSpacing * 2 + rabbitSize
            case .right:
                return defaultSpacing * 3 + rabbitSize * 2
            }
        }
    
   
    
}
