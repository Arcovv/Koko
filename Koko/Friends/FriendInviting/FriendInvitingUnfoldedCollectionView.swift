//
//  FriendInvitingUnfoldedCollectionView.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/12.
//

import UIKit
import SnapKit

final class FriendInvitingUnfoldedCollectionView: UICollectionView {
    typealias Cell = FriendInvitingUnfoldedCell
    
    static let lineSpacing: CGFloat = 10
    static let maxDisplayCellCount = 2
    
    static func defaultHeight() -> CGFloat {
        return Cell.defaultHeight * CGFloat(maxDisplayCellCount) + lineSpacing * CGFloat(maxDisplayCellCount - 1)
    }
    
    private(set) var friends: [Friend] = []
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = Self.lineSpacing
        
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        delegate = self
        dataSource = self
        
        layer.masksToBounds = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFriends(_ friends: [Friend]) {
        self.friends = friends
        reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendInvitingUnfoldedCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: Cell.defaultHeight
        )
    }
}

// MARK: - UICollectionViewDataSource

extension FriendInvitingUnfoldedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError()
        }
        
        let friend = self.friends[indexPath.row]
        cell.setFriend(friend)
        
        return cell
    }
}
