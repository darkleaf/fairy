module EventMachineHelper
  def set_em_steps(*steps)
    @@_em_steps = *steps
  end

  def em_step_complete(step)
    @@_em_steps.delete(step)
    EM.stop if @@_em_steps.empty?
  end
end
