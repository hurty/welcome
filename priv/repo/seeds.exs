alias Welcome.ATS
import Welcome.Factory

pierre = insert!(:pierre)
john = insert!(:john)
george = insert!(:george)
mary = insert!(:mary)

{:ok, _meet_up_stage} = ATS.create_stage(%{name: "A rencontrer", position: 0})
{:ok, interview_stage} = ATS.create_stage(%{name: "A entretien", position: 1})

ATS.create_application(john)
ATS.create_application(george)
ATS.create_application(mary)
{:ok, pierre_application} = ATS.create_application(pierre)

ATS.update_application(pierre_application, %{stage_id: interview_stage.id, position: 0})
