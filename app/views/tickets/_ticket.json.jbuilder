json.extract! ticket, :id, :title, :description, :due_date, :status_id, :progress, :user_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
