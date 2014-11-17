package com.groupfio.dao;

import java.sql.Timestamp;
import java.util.List;

public interface FioLicenseAdminEventDAO {

	public void logAdminEvent(String serialNumber, 
			String eventType,
			String eventDetails, 
			String eventComment,
			Timestamp applicationTimestamp,
			String byUsername, 
			boolean hasBeenApplied);

	public List getAllFioLicenseAdminEventsForSerialNumber(String serialNumber);

	void deleteAnyExistingFutureSuspendAdminEvents(String serialNumber);

	void deleteAllAdminEvents(String serialNumber);
}
