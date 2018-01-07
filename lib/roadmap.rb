module Roadmap

  def get_roadmap(roadmap_id)
    get_response("/roadmaps/#{roadmap_id}")
  end

  def get_checkpoint(checkpoint_id)
    get_response("/checkpoints/#{checkpoint_id}")
  end

  def create_submission(branch, commit, checkpoint_id, comment, enrollment_id)
    @body = {
      assignment_branch: branch,
      assignment_commit_link: commit,
      checkpoint_id: checkpoint_id,
      comment: comment,
      enrollment_id: enrollment_id
    }
    @body.delete_if {|key, value| value == nil }
    post_response('/checkpoint_submissions', @body)
  end
end
