const { QueryTypes } = require('sequelize');
const SpotInstancePricing = db.SpotInstancePricing;


async function identifyDuplicates() {
    const duplicates = await db.sequelize.query(
        `SELECT "CloudProvider", "InstanceType", "Region", "EffectiveStartDate", COUNT(*)
        FROM "spot_instance_pricing"
        GROUP BY "CloudProvider", "InstanceType", "Region", "EffectiveStartDate"
        HAVING COUNT(*) > 1;`,
        { type: QueryTypes.SELECT }
    );

    if (duplicates && duplicates.length > 0) {
        console.log("Duplicates found:", duplicates);
    } else {
        console.log("No duplicates found.");
    }
}

// Call the function
identifyDuplicates();
