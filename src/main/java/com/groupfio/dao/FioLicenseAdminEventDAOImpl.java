package com.groupfio.dao;

import java.sql.Timestamp;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.groupfio.model.FioLicenseAdminEvent;

@Repository
public class FioLicenseAdminEventDAOImpl implements FioLicenseAdminEventDAO {

	@Autowired
	private SessionFactory session;

	@Override
	public void logAdminEvent(String serialNumber, String eventType, String eventDetails,
			String eventComment, Timestamp applicationTimestamp,
			String byUsername, boolean hasBeenApplied) {
		
		FioLicenseAdminEvent adminEvent = new FioLicenseAdminEvent(serialNumber, eventType,
				eventDetails, eventComment, applicationTimestamp, byUsername,
				hasBeenApplied);
		//ids for this class must be manually assigned before calling save(): com.groupfio.model.FioLicenseAdminEvent
		adminEvent.setEventTimestamp(new Timestamp(System.currentTimeMillis()));

		
		session.getCurrentSession().save(adminEvent);

	}
	
	@Override
	public void deleteAnyExistingFutureSuspendAdminEvents(){
		Query q = session.getCurrentSession().createQuery("delete FioLicenseAdminEvent where eventType = :eventType and hasBeenApplied = false");
		q.setString("eventType", FioLicenseAdminEvent.EventType.SUSPEND.name());
		q.executeUpdate();
	}

}