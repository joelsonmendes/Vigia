import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

interface UserMetric {
  userId: string;
  classId: string;
  timestamp: admin.firestore.Timestamp;
  sleepIrregular: boolean;
  lowMobility: boolean;
  highNightUsage: boolean;
  lowActivity: boolean;
}

export const aggregateDailyMetrics = functions.firestore
  .document('user_metrics/{metricId}')
  .onCreate(async (snap, context) => {
    const metric = snap.data() as UserMetric;
    const { classId, sleepIrregular, lowMobility, highNightUsage, lowActivity } = metric;

    if (!classId) {
      console.warn("Métrica sem classId, ignorando.");
      return null;
    }

    const db = admin.firestore();
    const aggregateRef = db.collection('aggregate_metrics').doc(classId);

    return db.runTransaction(async (transaction) => {
      const aggregateDoc = await transaction.get(aggregateRef);
      let data: any = { 
        totalStudents: 0,
        sleepIrregularCount: 0,
        lowMobilityCount: 0,
        highNightUsageCount: 0,
        lowActivityCount: 0,
        lastUpdated: admin.firestore.FieldValue.serverTimestamp()
      };

      if (aggregateDoc.exists) {
        data = aggregateDoc.data();
      }

      const newTotal = data.totalStudents + 1;
      const newSleepIrregular = data.sleepIrregularCount + (sleepIrregular ? 1 : 0);
      const newLowMobility = data.lowMobilityCount + (lowMobility ? 1 : 0);
      const newHighNightUsage = data.highNightUsageCount + (highNightUsage ? 1 : 0);
      const newLowActivity = data.lowActivityCount + (lowActivity ? 1 : 0);

      transaction.set(aggregateRef, {
        totalStudents: newTotal,
        sleepIrregularCount: newSleepIrregular,
        lowMobilityCount: newLowMobility,
        highNightUsageCount: newHighNightUsage,
        lowActivityCount: newLowActivity,
        sleepIrregular: newTotal > 0 ? newSleepIrregular / newTotal : 0,
        lowMobility: newTotal > 0 ? newLowMobility / newTotal : 0,
        highNightUsage: newTotal > 0 ? newHighNightUsage / newTotal : 0,
        lowActivity: newTotal > 0 ? newLowActivity / newTotal : 0,
        lastUpdated: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });

      console.log(`✅ Agregado métrica para turma ${classId}`);
      return null;
    });
  });