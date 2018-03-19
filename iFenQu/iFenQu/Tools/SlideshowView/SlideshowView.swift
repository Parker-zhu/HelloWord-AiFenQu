//
//  SlideshowView.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/18.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//

import UIKit
import SDWebImage

public enum PageControlStyle {
    case none
    case system
    case fill
    case pill
    case snake
    case image
}


@objc protocol SlideshowViewDelegate: class {
    @objc func slideshowViewScrollView(_ slideshowView: SlideshowView, didSelectItemIndex index: NSInteger)
}

public typealias didSelectItemAtIndexClosure = (NSInteger) -> Void

class SlideshowView: UIView {
    
    // 滚动方向，默认horizontal
    open var scrollDirection: UICollectionViewScrollDirection = .horizontal {
        didSet {
            flowLayout?.scrollDirection = scrollDirection
            if scrollDirection == .horizontal {
                position = .centeredHorizontally
            }else{
                position = .centeredVertically
            }
        }
    }
    
    // 滚动间隔时间,默认2s
    open var autoScrollTimeInterval: TimeInterval = 5.0
    
    // 加载状态图 -- 这个是有数据，等待加载的占位图
    open var placeHolderImage: UIImage? = nil {
        didSet {
            if placeHolderImage != nil {
//                placeHolderViewImage = placeHolderImage
            }
        }
    }
    
    // 空数据页面显示占位图 -- 这个是没有数据，整个轮播器的占位图
    open var coverImage: UIImage? = nil {
        didSet {
            if coverImage != nil {
//                coverViewImage = coverImage
            }
        }
    }
    
    // 背景色
    open var collectionViewBackgroundColor: UIColor! = UIColor.clear
    
    // MARK: 图片属性
    // 图片显示Mode
    open var imageViewContentMode: UIViewContentMode? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: PageControl
    open var pageControlTintColor: UIColor = UIColor.lightGray {
        didSet {
            setupPageControl()
        }
    }
    // 当前显示颜色
    open var pageControlCurrentPageColor: UIColor = UIColor.white {
        didSet {
            setupPageControl()
        }
    }
    
    // MARK: CustomPageControl
    // 注意： 由于属性较多，所以请使用style对应的属性，如果没有标明则通用
    open var customPageControlStyle: PageControlStyle = .system {
        didSet {
            setupPageControl()
        }
    }
    // 颜色
    open var customPageControlTintColor: UIColor = UIColor.white {
        didSet {
            setupPageControl()
        }
    }
    // Indicator间距
    open var customPageControlIndicatorPadding: CGFloat = 8 {
        didSet {
            setupPageControl()
        }
    }
    
    // PageControl x轴间距
    open var pageControlLeadingOrTrialingContact: CGFloat = 28 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // PageControl bottom间距
    open var pageControlBottom: CGFloat = 11 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // 开启/关闭URL特殊字符处理
    open var isAddingPercentEncodingForURLString: Bool = false
    
    // PageControl x轴文本间距
    open var titleLeading: CGFloat = 15
    
    // PageControl
    open var pageControl: UIPageControl?
    
    // Custom PageControl
    open var customPageControl: UIView?
    
    // PageControlStyle == .fill
    // 圆大小
    open var FillPageControlIndicatorRadius: CGFloat = 4 {
        didSet {
            setupPageControl()
        }
    }
    
    // PageControlStyle == .pill || PageControlStyle == .snake
    // 当前的颜色
    open var customPageControlInActiveTintColor: UIColor = UIColor(white: 1, alpha: 0.3) {
        didSet {
            setupPageControl()
        }
    }
    
    // 自定义pageControl图标
    open var pageControlActiveImage: UIImage? = nil {
        didSet {
            setupPageControl()
        }
    }
    
    // 当前的pageControl图标
    open var pageControlInActiveImage: UIImage? = nil {
        didSet {
            setupPageControl()
        }
    }
    
    
    // MARK: 数据源
    // ImagePaths
    open var imagePaths: [String] = [] {
        didSet {
            totalItemsCount = imagePaths.count * 100
            if imagePaths.count > 1 {
                collectionView.isScrollEnabled = true
            }else{
                collectionView.isScrollEnabled = false
            }
            
            // 计算最大扩展区大小
            if scrollDirection == .horizontal {
                maxSwipeSize = CGFloat(imagePaths.count) * collectionView.frame.width
            }else{
                maxSwipeSize = CGFloat(imagePaths.count) * collectionView.frame.height
            }
            
            setupPageControl()
            
            collectionView.reloadData()
        }
    }
    
    // MARK: 间距属性
    
    
    // MARK: 文本相关属性
    // 文本颜色
    open var textColor: UIColor = UIColor.white
    
    // 文本行数
    open var numberOfLines: NSInteger = 2
    
    // 文本字体
    open var font: UIFont = UIFont.systemFont(ofSize: 15)
    
    // 文本区域背景颜色
    open var titleBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3)
    
    // MARK: 标题数据源
    // 标题
    open var titles: Array<String> = [] {
        didSet {
            if titles.count > 0 {
                if imagePaths.count == 0 {
                    imagePaths = titles
                }
            }
        }
    }
    
    // MARK: 闭包
    // 回调
    open var didSelectItemAtIndex: didSelectItemAtIndexClosure?
    
    // Delegate
    weak var delegate: SlideshowViewDelegate?
    
    // MARK: Private
    // Identifier
    fileprivate let identifier = "LLCycleScrollViewCell"
    
    // 数量
    fileprivate var totalItemsCount: NSInteger! = 1
    
    // 显示图片(CollectionView)
    fileprivate var collectionView: UICollectionView!
    
    // 最大伸展空间(防止出现问题，可外部设置)
    // 用于反方向滑动的时候，需要知道最大的contentSize
    fileprivate var maxSwipeSize: CGFloat = 0
    
    // 暂不开放
    // 用于反方向滑动的时候，需要知道最大的contentSize
    // open var maxContentSize: CGFloat = 0 {
    //    didSet {
    //        maxSwipeSize = maxContentSize
    //    }
    // }
    
    // 方向(swift后没有none，只能指定了)
    fileprivate var position: UICollectionViewScrollPosition! = .centeredHorizontally
    
    // 是否纯文本
    fileprivate var isOnlyTitle: Bool = false
    
    
    // Cell Height
    fileprivate var cellHeight: CGFloat = 56
    
    // FlowLayout
    lazy fileprivate var flowLayout: UICollectionViewFlowLayout? = {
        let tempFlowLayout = UICollectionViewFlowLayout.init()
        tempFlowLayout.minimumLineSpacing = 0
        tempFlowLayout.scrollDirection = .horizontal
        return tempFlowLayout
    }()
    
    // 计时器
    fileprivate var timer: Timer?
    
    // 加载状态图
    fileprivate var placeHolderViewImage: UIImage!
//        = UIImage(named: "LLCycleScrollView.bundle/llplaceholder.png", in: Bundle(for: LLCycleScrollView.self), compatibleWith: nil)
    
    // 空数据页面显示占位图
    fileprivate var coverViewImage: UIImage!
//        = UIImage(named: "LLCycleScrollView.bundle/llplaceholder.png", in: Bundle(for: LLCycleScrollView.self), compatibleWith: nil)
    
    // MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainView()
    }
    
    // MARK: 初始化
    open class func SlideshowViewWithFrame(_ frame: CGRect, imageURLPaths: [String]? = [], titles:[String]? = [], didSelectItemAtIndex: didSelectItemAtIndexClosure? = nil) -> SlideshowView {
        let llcycleScrollView: SlideshowView = SlideshowView.init(frame: frame)
        // Nil
        llcycleScrollView.imagePaths = []
        llcycleScrollView.titles = []
        
        if let imageURLPathList = imageURLPaths, imageURLPathList.count > 0 {
            llcycleScrollView.imagePaths = imageURLPathList
        }
        
        if let titleList = titles, titleList.count > 0 {
            llcycleScrollView.titles = titleList
        }
        
        if didSelectItemAtIndex != nil {
            llcycleScrollView.didSelectItemAtIndex = didSelectItemAtIndex
        }
        return llcycleScrollView
    }
    
    // MARK: 纯文本
    open class func llCycleScrollViewWithTitles(frame: CGRect, backImage: UIImage? = nil, titles: Array<String>? = [], didSelectItemAtIndex: didSelectItemAtIndexClosure? = nil) -> SlideshowView {
        let llcycleScrollView: SlideshowView = SlideshowView.init(frame: frame)
        // Nil
        llcycleScrollView.titles = []
        
        if let backImage = backImage {
            // 异步加载数据时候，第一个页面会出现placeholder image，可以用backImage来设置纯色图片等其他方式
            llcycleScrollView.coverImage = backImage
        }
        
        // Set isOnlyTitle
        llcycleScrollView.isOnlyTitle = true
        
        // Cell Height
        llcycleScrollView.cellHeight = frame.size.height
        
        // Titles Data
        if let titleList = titles, titleList.count > 0 {
            llcycleScrollView.titles = titleList
        }
        
        if didSelectItemAtIndex != nil {
            llcycleScrollView.didSelectItemAtIndex = didSelectItemAtIndex
        }
        return llcycleScrollView
    }
    
    
    // MARK: -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMainView()
    }
    
    // MARK: 添加UICollectionView
    private func setupMainView() {
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout!)
        collectionView.register(SlideshowViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.backgroundColor = collectionViewBackgroundColor
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        self.addSubview(collectionView)
    }
    
    // MARK: 添加Timer
    func setupTimer() {
        // 仅一张图不进行滚动操纵
        if self.imagePaths.count <= 1 { return }
        
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval as TimeInterval, target: self, selector: #selector(automaticScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    // MARK: 关闭倒计时
    func invalidateTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: 添加PageControl
    func setupPageControl() {
        // 重新添加
        if pageControl != nil {
            pageControl?.removeFromSuperview()
        }
        
        if customPageControl != nil {
            customPageControl?.removeFromSuperview()
        }
        
        if customPageControlStyle == .none {
            pageControl = UIPageControl.init()
            pageControl?.numberOfPages = self.imagePaths.count
        }
        
        if customPageControlStyle == .system {
            pageControl = UIPageControl.init()
            pageControl?.pageIndicatorTintColor = pageControlTintColor
            pageControl?.currentPageIndicatorTintColor = pageControlCurrentPageColor
            pageControl?.numberOfPages = self.imagePaths.count
            self.addSubview(pageControl!)
            pageControl?.isHidden = false
        }
        
        if customPageControlStyle == .fill {
            customPageControl = FilledPageControl.init(frame: CGRect.zero)
            customPageControl?.tintColor = customPageControlTintColor
            (customPageControl as! FilledPageControl).indicatorPadding = customPageControlIndicatorPadding
            (customPageControl as! FilledPageControl).indicatorRadius = FillPageControlIndicatorRadius
            (customPageControl as! FilledPageControl).pageCount = self.imagePaths.count
            self.addSubview(customPageControl!)
        }
        
        if customPageControlStyle == .pill {
            customPageControl = PillPageControl.init(frame: CGRect.zero)
            (customPageControl as! PillPageControl).indicatorPadding = customPageControlIndicatorPadding
            (customPageControl as! PillPageControl).activeTint = customPageControlTintColor
            (customPageControl as! PillPageControl).inactiveTint = customPageControlInActiveTintColor
            (customPageControl as! PillPageControl).pageCount = self.imagePaths.count
            self.addSubview(customPageControl!)
        }
        
        if customPageControlStyle == .snake {
            customPageControl = SnakePageControl.init(frame: CGRect.zero)
            (customPageControl as! SnakePageControl).activeTint = customPageControlTintColor
            (customPageControl as! SnakePageControl).indicatorPadding = customPageControlIndicatorPadding
            (customPageControl as! SnakePageControl).indicatorRadius = FillPageControlIndicatorRadius
            (customPageControl as! SnakePageControl).inactiveTint = customPageControlInActiveTintColor
            (customPageControl as! SnakePageControl).pageCount = self.imagePaths.count
            self.addSubview(customPageControl!)
        }
        
        if customPageControlStyle == .image {
            pageControl = ImagePageControl()
            pageControl?.pageIndicatorTintColor = UIColor.clear
            pageControl?.currentPageIndicatorTintColor = UIColor.clear
            
            if let activeImage = pageControlActiveImage {
                (pageControl as? ImagePageControl)?.dotActiveImage = activeImage
            }
            if let inActiveImage = pageControlInActiveImage {
                (pageControl as? ImagePageControl)?.dotInActiveImage = inActiveImage
            }
            
            pageControl?.numberOfPages = self.imagePaths.count
            self.addSubview(pageControl!)
            pageControl?.isHidden = false
        }
    }
    
    // MARK: layoutSubviews
    override open func layoutSubviews() {
        super.layoutSubviews()
        // CollectionView
        collectionView.frame = self.bounds
        // Cell Size
        flowLayout?.itemSize = self.frame.size
        // Page Frame
        if customPageControlStyle == .none || customPageControlStyle == .system || customPageControlStyle == .image {
            pageControl?.frame = CGRect.init(x: 0, y: self.height - pageControlBottom, width: UIScreen.main.bounds.width, height: 10)
            
        }else{
            var y = self.height - pageControlBottom
            
            // pill
            if customPageControlStyle == .pill {
                y+=5
            }
            
            let oldFrame = customPageControl?.frame
            customPageControl?.frame = CGRect.init(x: (oldFrame?.origin.x)!, y: y, width: (oldFrame?.size.width)!, height: 10)
            
        }
        
        if collectionView.contentOffset.x == 0 && totalItemsCount > 0 {
            var targetIndex = 0
            
            targetIndex = totalItemsCount/2
            
            collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: false)
        }
    }
    
    // MARK: Actions
    @objc func automaticScroll() {
        if totalItemsCount == 0 {return}
        let targetIndex = currentIndex() + 1
        scollToIndex(targetIndex: targetIndex)
    }
    
    func scollToIndex(targetIndex: Int) {
        if targetIndex >= totalItemsCount {
            
            collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
            
            return
        }
        collectionView.scrollToItem(at: IndexPath.init(item: targetIndex, section: 0), at: position, animated: true)
    }
    
    func currentIndex() -> NSInteger {
        if collectionView.width == 0 || collectionView.height == 0 {
            return 0
        }
        var index = 0
        if flowLayout?.scrollDirection == UICollectionViewScrollDirection.horizontal {
            index = NSInteger(collectionView.contentOffset.x + (flowLayout?.itemSize.width)! * 0.5)/NSInteger((flowLayout?.itemSize.width)!)
        }else {
            index = NSInteger(collectionView.contentOffset.y + (flowLayout?.itemSize.height)! * 0.5)/NSInteger((flowLayout?.itemSize.height)!)
        }
        return index
    }
    
    func pageControlIndexWithCurrentCellIndex(index: NSInteger) -> (Int) {
        return imagePaths.count == 0 ? 0 : Int(index % imagePaths.count)
    }
    
}

extension SlideshowView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if imagePaths.count == 0 { return }
        let indexOnPageControl = pageControlIndexWithCurrentCellIndex(index: currentIndex())
        if customPageControlStyle == .none || customPageControlStyle == .system || customPageControlStyle == .image {
            pageControl?.currentPage = indexOnPageControl
        }else{
            var progress: CGFloat = 999
            // 方向
            if scrollDirection == .horizontal {
                var currentOffsetX = scrollView.contentOffset.x - (CGFloat(totalItemsCount) * scrollView.frame.size.width) / 2
                if currentOffsetX < 0 {
                    if currentOffsetX >= -scrollView.frame.size.width{
                        currentOffsetX = CGFloat(indexOnPageControl) * scrollView.frame.size.width
                    }else if currentOffsetX <= -maxSwipeSize{
                        collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
                    }else{
                        currentOffsetX = maxSwipeSize + currentOffsetX
                    }
                }
                if currentOffsetX >= CGFloat(self.imagePaths.count) * scrollView.frame.size.width {
                    collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
                }
                progress = currentOffsetX / scrollView.frame.size.width
            }else if scrollDirection == .vertical{
                var currentOffsetY = scrollView.contentOffset.y - (CGFloat(totalItemsCount) * scrollView.frame.size.height) / 2
                if currentOffsetY < 0 {
                    if currentOffsetY >= -scrollView.frame.size.height{
                        currentOffsetY = CGFloat(indexOnPageControl) * scrollView.frame.size.height
                    }else if currentOffsetY <= -maxSwipeSize{
                        collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
                    }else{
                        currentOffsetY = maxSwipeSize + currentOffsetY
                    }
                }
                if currentOffsetY >= CGFloat(self.imagePaths.count) * scrollView.frame.size.height{
                    collectionView.scrollToItem(at: IndexPath.init(item: Int(totalItemsCount/2), section: 0), at: position, animated: false)
                }
                progress = currentOffsetY / scrollView.frame.size.height
            }
            
            if progress == 999 {
                progress = CGFloat(indexOnPageControl)
            }
            // progress
            if customPageControlStyle == .fill {
                (customPageControl as! FilledPageControl).progress = progress
            }else if customPageControlStyle == .pill {
                (customPageControl as! PillPageControl).progress = progress
            }else if customPageControlStyle == .snake {
                (customPageControl as! SnakePageControl).progress = progress
            }
        }
        
    }

    // MARK: ScrollView Begin Drag
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }

    // MARK: ScrollView End Drag
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupTimer()
    }


    // MARK: UICollectionViewDataSource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount == 0 ? 1:totalItemsCount
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SlideshowViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SlideshowViewCell
        // Setting
        cell.titleFont = font
        cell.titleLabelTextColor = textColor
        cell.titleBackViewBackgroundColor = titleBackgroundColor
        cell.titleLines = numberOfLines
        
        // Leading
        cell.titleLabelLeading = titleLeading
        
        // Only Title
        if isOnlyTitle && titles.count > 0{
            cell.titleLabelHeight = cellHeight
            
            let itemIndex = pageControlIndexWithCurrentCellIndex(index: indexPath.item)
            cell.title = titles[itemIndex]
        }else{
            // Mode
            if let imageViewContentMode = imageViewContentMode {
                cell.imageView.contentMode = imageViewContentMode
            }
            
            // 0==count 占位图
            if imagePaths.count == 0 {
//                cell.imageView.image = coverViewImage
            }else{
                let itemIndex = pageControlIndexWithCurrentCellIndex(index: indexPath.item)
                let imagePath = imagePaths[itemIndex]
                
                // 根据imagePath，来判断是网络图片还是本地图
                if imagePath.hasPrefix("http") {
                    
//                    cell.imageView.setImageWith(<#T##url: URL##URL#>, placeholderImage: <#T##UIImage?#>)
                }else{
                    if let image = UIImage.init(named: imagePath) {
                        cell.imageView.image = image;
                    }else{
                        cell.imageView.image = UIImage.init(contentsOfFile: imagePath)
                    }
                }
                
                // 对冲数据判断
                if itemIndex <= titles.count-1 {
                    cell.title = titles[itemIndex]
                }else{
                    cell.title = ""
                }
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didSelectItemAtIndexPath = didSelectItemAtIndex {
        didSelectItemAtIndexPath(pageControlIndexWithCurrentCellIndex(index: indexPath.item))
        }else if let delegate = delegate {
            delegate.slideshowViewScrollView(self, didSelectItemIndex: indexPath.item)
        }
    }

}
