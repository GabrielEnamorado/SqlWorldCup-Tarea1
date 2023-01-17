  select team_id, team_name, 
     coalesce(sum(case when team_id = host_team then 
                   (
                    case when host_goals > guest_goals then 3
                    when host_goals = guest_goals then 1
                    when host_goals < guest_goals then 0
                    end
                   ) 
                   when team_id = guest_team then
                   (
                   case when guest_goals > host_goals then 3
                   when guest_goals = host_goals then 1
                   when guest_goals < host_goals then 0
                   end
                   )
                   end), 0) as num_points
    from Teams
    left join Matches
    on 
    Teams.team_id = Matches.host_team
    or Teams.team_id = Matches.guest_team
    group by team_id, team_name
    order by num_points desc, team_id;