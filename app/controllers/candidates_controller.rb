class CandidatesController < ApplicationController
  
  def index
    # 列出清單，抓出來的是一堆資料，給他複數
    @candidates = Candidate.all
  end

  def show
    @candidate = Candidate.find_by(id: params[:id])
  end

  def new 
    @candidate = Candidate.new
    # 不要在erb裡做運算，所以在act裡做運算，然後將變數帶給erb，為了使他可以存在於這個act方法之外，所以使用了實體變數
  end

  def create
                         #從:candidate裡取資料，但只允許()內的資料過來 ，就不會被添加不會允許的資料近來 
    @candidate = Candidate.new(candidate_params)
    
    if @candidate.save
      # flash，在畫面中呈現過一次，只要出現過被印出來，再重新整理過後就會消失掉，為一個hash，給他一個key，依慣例來說會使用notice
      flash[:notice] = "新增成功"
      redirect_to candidates_path
      # 可以透過rails c查詢寫入成功的資料
    else
      # NG
      # redirect_to是轉去全新的頁面，但這樣原本的頁面資料就要重新輸入
      # redirect_to '/candidates/new'
      # 借new.html.erb這個畫面重新渲染一次，不會執行new action，因為實體變數的關係所以保留了本來輸入的資料
      render :new
    end
    # debugger
    # 做debug用，會造成無窮迴圈，如果要離開就在終端機輸入continue或c
  end

  def edit
    @candidate = Candidate.find_by(id: params[:id])
  end

  def update
    @candidate = Candidate.find_by(id: params[:id])

    if @candidate.update(candidate_params)
      flash[:notice] = "更新成功"
      redirect_to candidates_path
    else
      render :edit
    end
  end

  def destroy 
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy

    flash[:notice] = '刪除成功'
    redirect_to candidates_path
  end

  def vote
    @candidate = Candidate.find_by(id: params[:id])

    # 第一個是從投票紀錄計算
    # VoteLog.create(candidate, ip_address:request.remote_ip)
    # 第二個是從候選人的得票紀錄計算
    @candidate.vote_logs.create(ip_address:request.remote_ip)


    # 以下寫法可以無限制的投票，不好
    # @candidate.votes = @candidate.votes + 1 等同下方的rails寫法
    # @candidate.increment(:votes)
    # @candidate.save

    flash[:notice] = "投票成功"
    redirect_to candidates_path

  end

  private
  def candidate_params
    # 經常會使用，直接幫他做個方法做分類方便取用及修改
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end

end